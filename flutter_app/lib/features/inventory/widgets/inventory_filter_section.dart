// lib/features/inventory/widgets/inventory_filter_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/inventory_bloc.dart';
import '../bloc/inventory_event.dart';

class InventoryFilterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemNoController = TextEditingController();
    final itemNameController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: itemNoController,
              decoration: InputDecoration(labelText: '品番'),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: '品名'),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              context.read<InventoryBloc>().add(FilterInventory(
                itemNo: itemNoController.text,
                itemName: itemNameController.text,
              ));
            },
            child: Text('検索'),
          ),
        ],
      ),
    );
  }
}
