// lib/features/supplier/widgets/supplier_form.dart

import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/supplier/models/supplier.dart';
import 'package:logistics/features/supplier/bloc/supplier_bloc.dart';
import 'package:logistics/features/supplier/bloc/supplier_event.dart';

class SupplierForm extends StatefulWidget {
  final Supplier? supplier;

  SupplierForm({this.supplier});

  @override
  _SupplierFormState createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _contactEmail;
  late String _address;

  @override
  void initState() {
    super.initState();
    _name = widget.supplier?.name ?? '';
    _contactEmail = widget.supplier?.contactEmail ?? '';
    _address = widget.supplier?.address ?? '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final supplier = Supplier(
        id: widget.supplier?.id ?? Uuid().v4(),
        name: _name,
        contactEmail: _contactEmail,
        address: _address,
      );
      if (widget.supplier == null) {
        context.read<SupplierBloc>().add(AddSupplier(supplier));
      } else {
        context.read<SupplierBloc>().add(UpdateSupplier(supplier));
      }
      Navigator.pop(context);
    }
  }

  void _deleteSupplier() {
    if (widget.supplier != null) {
      context.read<SupplierBloc>().add(DeleteSupplier(widget.supplier!.id));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.supplier != null;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: _name,
            decoration: InputDecoration(labelText: 'サプライヤー名'),
            validator: (value) =>
                value!.isEmpty ? 'サプライヤー名を入力してください' : null,
            onSaved: (value) => _name = value!,
          ),
          TextFormField(
            initialValue: _contactEmail,
            decoration: InputDecoration(labelText: 'メールアドレス'),
            validator: (value) =>
                value!.isEmpty ? 'メールアドレスを入力してください' : null,
            onSaved: (value) => _contactEmail = value!,
          ),
          TextFormField(
            initialValue: _address,
            decoration: InputDecoration(labelText: '住所'),
            validator: (value) =>
                value!.isEmpty ? '住所を入力してください' : null,
            onSaved: (value) => _address = value!,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text(isEditing ? '更新' : '登録'),
          ),
        ],
      ),
    );
  }
}
