// lib/features/supplier/screens/supplier_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:logistics/features/supplier/models/supplier.dart';
import 'package:logistics/features/supplier/screens/supplier_form_screen.dart';
import 'package:logistics/features/supplier/widgets/supplier_detail_view.dart';

class SupplierDetailScreen extends StatelessWidget {
  final Supplier supplier;

  SupplierDetailScreen({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('サプライヤー詳細'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupplierFormScreen(supplier: supplier),
                ),
              );
            },
          ),
        ],
      ),
      body: SupplierDetailView(supplier: supplier),
    );
  }
}
