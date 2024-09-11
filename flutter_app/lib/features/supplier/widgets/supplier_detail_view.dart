// lib/features/supplier/widgets/supplier_detail_view.dart

import 'package:flutter/material.dart';
import 'package:logistics/features/supplier/models/supplier.dart';

class SupplierDetailView extends StatelessWidget {
  final Supplier supplier;

  SupplierDetailView({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('サプライヤー名: ${supplier.name}'),
          SizedBox(height: 8),
          Text('メールアドレス: ${supplier.contactEmail}'),
          SizedBox(height: 8),
          Text('住所: ${supplier.address}'),
        ],
      ),
    );
  }
}
