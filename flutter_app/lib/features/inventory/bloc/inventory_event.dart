// lib/features/inventory/bloc/inventory_event.dart

import 'package:equatable/equatable.dart';

abstract class InventoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadInventory extends InventoryEvent {}

class FilterInventory extends InventoryEvent {
  final String itemNo;
  final String itemName;

  FilterInventory({required this.itemNo, required this.itemName});

  @override
  List<Object> get props => [itemNo, itemName];
}
