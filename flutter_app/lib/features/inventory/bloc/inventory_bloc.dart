// lib/features/inventory/bloc/inventory_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/inventory_repository.dart';
import 'inventory_event.dart';
import 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepository inventoryRepository;

  InventoryBloc(this.inventoryRepository) : super(InventoryInitial()) {
    on<LoadInventory>((event, emit) async {
      emit(InventoryLoading());
      try {
        final inventoryItems = await inventoryRepository.loadInventoryItems();
        emit(InventoryLoaded(inventoryItems: inventoryItems));
      } catch (e) {
        emit(InventoryLoadFailure(e.toString()));
      }
    });

    on<FilterInventory>((event, emit) async {
      emit(InventoryLoading());
      try {
        final filteredItems = await inventoryRepository.filterInventoryItems(
          event.itemNo,
          event.itemName,
        );
        emit(InventoryLoaded(inventoryItems: filteredItems));
      } catch (e) {
        emit(InventoryLoadFailure(e.toString()));
      }
    });
  }
}
