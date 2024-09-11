// lib/features/inventory/screens/inventory_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/inventory/repository/inventory_repository.dart';
import '../bloc/inventory_bloc.dart';
import '../bloc/inventory_event.dart';
import '../bloc/inventory_state.dart';
import '../widgets/inventory_filter_section.dart';
import '../widgets/inventory_list_view.dart';

class InventoryListScreen extends StatelessWidget {
  final InventoryRepository inventoryRepository;

  InventoryListScreen({required this.inventoryRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('在庫一覧'),
      ),
      body: BlocProvider(
        create: (context) => InventoryBloc(inventoryRepository)..add(LoadInventory()),
        child: InventoryView(),
      ),
    );
  }
}

class InventoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InventoryFilterSection(),
        Expanded(
          child: BlocBuilder<InventoryBloc, InventoryState>(
            builder: (context, state) {
              if (state is InventoryLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is InventoryLoaded) {
                return InventoryListView(inventoryItems: state.inventoryItems);
              } else if (state is InventoryLoadFailure) {
                return Center(child: Text('エラー: ${state.error}'));
              } else {
                return Center(child: Text('データが見つかりません'));
              }
            },
          ),
        ),
      ],
    );
  }
}
