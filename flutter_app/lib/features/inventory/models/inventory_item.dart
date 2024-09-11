// lib/features/inventory/models/inventory_item.dart

import 'package:equatable/equatable.dart';

class InventoryItem extends Equatable {
  final String itemNo;
  final String itemName;
  final int stock;
  final int safetyStock;
  final String location; // 追加項目：保管場所
  final String supplier; // 追加項目：サプライヤー

  InventoryItem({
    required this.itemNo,
    required this.itemName,
    required this.stock,
    required this.safetyStock,
    required this.location,
    required this.supplier,
  });

  @override
  List<Object> get props => [itemNo, itemName, stock, safetyStock, location, supplier];

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      itemNo: json['item_no'],
      itemName: json['item_name'],
      stock: json['stock'],
      safetyStock: json['safety_stock'],
      location: json['location'],
      supplier: json['supplier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_no': itemNo,
      'item_name': itemName,
      'stock': stock,
      'safety_stock': safetyStock,
      'location': location,
      'supplier': supplier,
    };
  }
}
