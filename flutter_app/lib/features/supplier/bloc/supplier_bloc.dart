// lib/features/supplier/bloc/supplier_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'supplier_event.dart';
import 'supplier_state.dart';
import '../repository/supplier_repository.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  final SupplierRepository supplierRepository;

  SupplierBloc(this.supplierRepository) : super(SupplierLoading()) {
    on<LoadSuppliers>((event, emit) async {
      emit(SupplierLoading());
      try {
        final suppliers = await supplierRepository.loadSuppliers();
        emit(SupplierLoaded(suppliers));
      } catch (e) {
        emit(SupplierOperationFailure(e.toString()));
      }
    });

    on<AddSupplier>((event, emit) async {
      try {
        await supplierRepository.addSupplier(event.supplier);
        final suppliers = await supplierRepository.loadSuppliers();
        emit(SupplierLoaded(suppliers));
      } catch (e) {
        emit(SupplierOperationFailure(e.toString()));
      }
    });

    on<UpdateSupplier>((event, emit) async {
      try {
        await supplierRepository.updateSupplier(event.supplier);
        final suppliers = await supplierRepository.loadSuppliers();
        emit(SupplierLoaded(suppliers));
      } catch (e) {
        emit(SupplierOperationFailure(e.toString()));
      }
    });

    on<DeleteSupplier>((event, emit) async {
      try {
        await supplierRepository.deleteSupplier(event.id);
        final suppliers = await supplierRepository.loadSuppliers();
        emit(SupplierLoaded(suppliers));
      } catch (e) {
        emit(SupplierOperationFailure(e.toString()));
      }
    });
  }
}
