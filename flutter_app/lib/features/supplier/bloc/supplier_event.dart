// lib/features/supplier/bloc/supplier_event.dart

import 'package:equatable/equatable.dart';
import '../models/supplier.dart';

abstract class SupplierEvent extends Equatable {
  const SupplierEvent();

  @override
  List<Object?> get props => [];
}

class LoadSuppliers extends SupplierEvent {}

class AddSupplier extends SupplierEvent {
  final Supplier supplier;

  AddSupplier(this.supplier);

  @override
  List<Object?> get props => [supplier];
}

class UpdateSupplier extends SupplierEvent {
  final Supplier supplier;

  UpdateSupplier(this.supplier);

  @override
  List<Object?> get props => [supplier];
}

class DeleteSupplier extends SupplierEvent {
  final String id;

  DeleteSupplier(this.id);

  @override
  List<Object?> get props => [id];
}
