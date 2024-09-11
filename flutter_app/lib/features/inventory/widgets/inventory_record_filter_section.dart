// lib/features/inventory/widgets/inventory_record_filter_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/inventory_bloc.dart';
import '../bloc/inventory_event.dart';

class InventoryRecordFilterSection extends StatelessWidget {
  final String? initialItemNo;

  InventoryRecordFilterSection({this.initialItemNo});

  @override
  Widget build(BuildContext context) {
    final itemNoController = TextEditingController(text: initialItemNo);
    final itemNameController = TextEditingController();
    final dateController = TextEditingController();

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
          Expanded(
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: '日時'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dateController.text = pickedDate.toIso8601String().substring(0, 10);
                }
              },
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
