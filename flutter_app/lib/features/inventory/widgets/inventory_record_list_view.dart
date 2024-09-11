// lib/features/inventory/widgets/inventory_record_list_view.dart

import 'package:flutter/material.dart';
import '../models/inventory_item.dart';

class InventoryRecordListView extends StatelessWidget {
  final List<InventoryItem> records;

  InventoryRecordListView({required this.records});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return ListTile(
          title: Text(record.itemName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('品番: ${record.itemNo}'),
              Text('日時: ${DateTime.now().toIso8601String().substring(0, 10)}'), // サンプルデータのため固定値を使用
              Text('入庫数: ${record.stock ~/ 2}'), // 仮の入庫数
              Text('出庫数: ${record.stock ~/ 4}'), // 仮の出庫数
              Text('在庫数: ${record.stock}'),
            ],
          ),
        );
      },
    );
  }
}
