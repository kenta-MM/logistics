// lib/features/supplier/repository/supplier_repository.dart

import 'package:logistics/features/common/repositories/api_repository.dart';
import 'package:uuid/uuid.dart';
import '../models/supplier.dart';

class SupplierRepository {
  final ApiRepository apiRepository;

  SupplierRepository({required this.apiRepository});

  final List<Supplier> _suppliers = List.generate(
    20,
    (index) => Supplier(
      id: Uuid().v4(),
      name: 'Supplier $index',
      contactEmail: 'supplier$index@example.com',
      address: '1234 Main St, City $index',
    ),
  );

  Future<List<Supplier>> loadSuppliers() async {
    return _suppliers;
  }

  Future<void> addSupplier(Supplier supplier) async {
    _suppliers.add(supplier);
  }

  Future<void> updateSupplier(Supplier supplier) async {
    final index = _suppliers.indexWhere((s) => s.id == supplier.id);
    if (index != -1) {
      _suppliers[index] = supplier;
    }
  }

  Future<void> deleteSupplier(String id) async {
    _suppliers.removeWhere((s) => s.id == id);
  }
}
