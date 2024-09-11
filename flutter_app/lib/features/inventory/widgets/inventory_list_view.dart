import 'package:flutter/material.dart';
import '../models/inventory_item.dart';
import '../screens/inventory_detail_screen.dart';
import '../screens/inventory_record_screen.dart';

class InventoryListView extends StatelessWidget {
  final List<InventoryItem> inventoryItems;

  InventoryListView({required this.inventoryItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ヘッダー
        Container(
          color: Colors.grey[300], // ヘッダーの背景色
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Expanded(child: Text('品番', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('品名', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('在庫数', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('安全在庫数', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('保管場所', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('サプライヤ', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        // 在庫アイテムのリスト
        Expanded(
          child: ListView.builder(
            itemCount: inventoryItems.length,
            itemBuilder: (context, index) {
              final item = inventoryItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryDetailScreen(inventoryItem: item),
                    ),
                  );
                },
                onDoubleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InventoryRecordScreen(itemNo: item.itemNo),
                    ),
                  );
                },
                child: Container(
                  color: item.stock < item.safetyStock ? Colors.red.withOpacity(0.3) : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(item.itemNo)),
                        Expanded(child: Text(item.itemName)),
                        Expanded(child: Text(item.stock.toString())),
                        Expanded(child: Text(item.safetyStock.toString())),
                        Expanded(child: Text(item.location)),
                        Expanded(child: Text(item.supplier)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
