import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_bloc.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_event.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_state.dart';

class PaginationControlSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              final state = context.read<ReceiveOrderBloc>().state as OrdersLoaded;
              context.read<ReceiveOrderBloc>().add(
                FilterOrders(
                  selectedStatus: state.orders.first.orderStatus,
                  selectedSupplier: state.orders.first.sendOrderSupplier,
                  orderNoFilter: '',
                  partsNoFilter: '',
                ),
              );
            },
            child: Text('検索'),
          ),
          BlocBuilder<ReceiveOrderBloc, ReceiveOrderState>(
            builder: (context, state) {
              if (state is OrdersLoaded) {
                return Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: state.currentPage > 0
                          ? () => context.read<ReceiveOrderBloc>().add(ChangePage(newPage: state.currentPage - 1))
                          : null,
                    ),
                    Text('${state.currentPage + 1} / ${state.totalPages}'),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: state.currentPage < state.totalPages - 1
                          ? () => context.read<ReceiveOrderBloc>().add(ChangePage(newPage: state.currentPage + 1))
                          : null,
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
