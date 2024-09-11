// lib/features/supplier/screens/supplier_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/supplier/bloc/supplier_bloc.dart';
import 'package:logistics/features/supplier/bloc/supplier_event.dart';
import 'package:logistics/features/supplier/models/supplier.dart';
import 'package:logistics/features/supplier/widgets/supplier_form.dart';

class SupplierFormScreen extends StatelessWidget {
  final Supplier? supplier;

  SupplierFormScreen({this.supplier});

  @override
  Widget build(BuildContext context) {
    final isEditing = supplier != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'サプライヤー編集' : 'サプライヤー登録'),
        actions: isEditing
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    if (supplier != null) {
                      context.read<SupplierBloc>().add(DeleteSupplier(supplier!.id));
                      Navigator.pop(context);
                    }
                  },
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SupplierForm(supplier: supplier),
      ),
    );
  }
}
