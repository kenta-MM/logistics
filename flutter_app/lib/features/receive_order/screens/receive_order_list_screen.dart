import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_bloc.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_event.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_state.dart';
import 'package:logistics/features/receive_order/repository/receive_order_repository.dart';
import 'package:logistics/features/receive_order/widgets/order_filter_section.dart';
import 'package:logistics/features/receive_order/widgets/order_list_view.dart';
import 'package:logistics/features/receive_order/widgets/pagination_control_section.dart';

class ReceiveOrderListScreen extends StatelessWidget {
  final ReceiveOrderRepository receiveOrderRepository;

  ReceiveOrderListScreen({required this.receiveOrderRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('受注一覧'),
      ),
      body: BlocProvider(
        create: (context) => ReceiveOrderBloc(receiveOrderRepository)..add(FetchOrders()),
        child: ReceiveOrderView(),
      ),
    );
  }
}


class ReceiveOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OrderFilterSection(),
        PaginationControlSection(),
        Expanded(
          child: BlocBuilder<ReceiveOrderBloc, ReceiveOrderState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is OrdersLoaded) {
                return OrderListView(orders: state.orders);
              } else if (state is OrdersLoadFailure) {
                return Center(child: Text('エラー: ${state.error}'));
              } else {
                return Center(child: Text('データが見つかりません'));
              }
            },
          ),
        ),
      ],
    );
  }
}