// lib/features/inventory/bloc/inventory_state.dart

import 'package:equatable/equatable.dart';
import '../models/inventory_item.dart';

abstract class InventoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<InventoryItem> inventoryItems;

  InventoryLoaded({required this.inventoryItems});

  @override
  List<Object> get props => [inventoryItems];
}

class InventoryLoadFailure extends InventoryState {
  final String error;

  InventoryLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
