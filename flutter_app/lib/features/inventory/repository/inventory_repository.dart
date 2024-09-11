// lib/features/inventory/repository/inventory_repository.dart

import 'dart:math';
import 'package:logistics/features/common/repositories/api_repository.dart';

import '../models/inventory_item.dart';

class InventoryRepository {
  final ApiRepository apiRepository;

  InventoryRepository({required this.apiRepository});
  final List<InventoryItem> _inventoryItems = _generateInventoryItems();

  static List<InventoryItem> _generateInventoryItems() {
    final random = Random();
    final locations = ['A1', 'B2', 'C3', 'D4', 'E5'];
    final suppliers = ['サプライヤーA', 'サプライヤーB', 'サプライヤーC'];

    return List.generate(20, (index) {
      final itemNo = 'ITEM${index + 1}'.padLeft(5, '0');
      final itemName = '商品${index + 1}';
      final stock = random.nextInt(100);
      final safetyStock = 50; // 一律で安全在庫を50に設定
      final location = locations[random.nextInt(locations.length)];
      final supplier = suppliers[random.nextInt(suppliers.length)];

      return InventoryItem(
        itemNo: itemNo,
        itemName: itemName,
        stock: stock,
        safetyStock: safetyStock,
        location: location,
        supplier: supplier,
      );
    });
  }

  Future<List<InventoryItem>> loadInventoryItems() async {
    return _inventoryItems;
  }

  Future<List<InventoryItem>> filterInventoryItems(String itemNo, String itemName) async {
    return _inventoryItems.where((item) {
      final matchesItemNo = itemNo.isEmpty || item.itemNo.contains(itemNo);
      final matchesItemName = itemName.isEmpty || item.itemName.contains(itemName);

      return matchesItemNo && matchesItemName;
    }).toList();
  }
}
