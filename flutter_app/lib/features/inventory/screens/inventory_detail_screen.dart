// lib/features/inventory/screens/inventory_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/inventory_item.dart';

class InventoryDetailScreen extends StatelessWidget {
  final InventoryItem inventoryItem;

  InventoryDetailScreen({required this.inventoryItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在庫詳細: ${inventoryItem.itemName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('品番: ${inventoryItem.itemNo}'),
            Text('品名: ${inventoryItem.itemName}'),
            Text('在庫数: ${inventoryItem.stock}'),
            Text('安全在庫: ${inventoryItem.safetyStock}'),
            Text('保管場所: ${inventoryItem.location}'),
            Text('サプライヤー: ${inventoryItem.supplier}'),
          ],
        ),
      ),
    );
  }
}
