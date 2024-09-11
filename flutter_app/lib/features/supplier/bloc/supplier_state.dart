// lib/features/supplier/bloc/supplier_state.dart

import 'package:equatable/equatable.dart';
import '../models/supplier.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();

  @override
  List<Object?> get props => [];
}

class SupplierLoading extends SupplierState {}

class SupplierLoaded extends SupplierState {
  final List<Supplier> suppliers;

  SupplierLoaded(this.suppliers);

  @override
  List<Object?> get props => [suppliers];
}

class SupplierOperationSuccess extends SupplierState {}

class SupplierOperationFailure extends SupplierState {
  final String error;

  SupplierOperationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
