// lib/features/supplier/screens/supplier_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/supplier/bloc/supplier_bloc.dart';
import 'package:logistics/features/supplier/bloc/supplier_state.dart';
import 'package:logistics/features/supplier/screens/supplier_form_screen.dart';
import 'package:logistics/features/supplier/widgets/supplier_list_view.dart';

class SupplierListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('サプライヤー一覧'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupplierFormScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SupplierBloc, SupplierState>(
        builder: (context, state) {
          if (state is SupplierLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SupplierLoaded) {
            return SupplierListView(suppliers: state.suppliers);
          } else if (state is SupplierOperationFailure) {
            return Center(child: Text('エラー: ${state.error}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
