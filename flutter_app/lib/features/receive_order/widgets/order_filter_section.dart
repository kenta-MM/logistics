import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_bloc.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_event.dart';
import 'package:logistics/features/receive_order/bloc/receive_order_state.dart';

class OrderFilterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDropdown(
                context,
                label: '発注先',
                items: ['', '部品製造会社A', '部品製造会社B', '部品製造会社C', '部品製造会社D', '部品製造会社E'],
                onChanged: (value) {
                  final state = context.read<ReceiveOrderBloc>().state as OrdersLoaded;
                  context.read<ReceiveOrderBloc>().add(
                    FilterOrders(
                      selectedStatus: state.orders.first.orderStatus,
                      selectedSupplier: value!,
                      orderNoFilter: '',
                      partsNoFilter: '',
                    ),
                  );
                },
              ),
              _buildDropdown(
                context,
                label: '注文ステータス',
                items: ['', '新規', '処理中', '発送済み', '完了', 'キャンセル'],
                onChanged: (value) {
                  final state = context.read<ReceiveOrderBloc>().state as OrdersLoaded;
                  context.read<ReceiveOrderBloc>().add(
                    FilterOrders(
                      selectedStatus: value!,
                      selectedSupplier: state.orders.first.sendOrderSupplier,
                      orderNoFilter: '',
                      partsNoFilter: '',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTextField(context, label: '受注注番', onChanged: (value) {}),
              _buildTextField(context, label: '品番', onChanged: (value) {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(BuildContext context, {
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Expanded(
      child: Row(
        children: [
          Text('$label:'),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: items.first,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(labelText: label),
        onChanged: onChanged,
      ),
    );
  }
}
