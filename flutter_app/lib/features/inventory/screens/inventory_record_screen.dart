// lib/features/inventory/screens/inventory_record_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/features/inventory/repository/inventory_repository.dart';
import 'package:logistics/features/inventory/widgets/inventory_record_filter_section.dart';
import 'package:logistics/features/inventory/widgets/inventory_record_list_view.dart';
import '../bloc/inventory_bloc.dart';
import '../bloc/inventory_event.dart';
import '../bloc/inventory_state.dart';

class InventoryRecordScreen extends StatelessWidget {
  final String? itemNo;

  InventoryRecordScreen({this.itemNo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('入出庫記録'),
      ),
      body: BlocProvider(
        create: (context) => InventoryBloc(context.read<InventoryRepository>())..add(LoadInventory()),
        child: InventoryRecordView(itemNo: itemNo),
      ),
    );
  }
}

class InventoryRecordView extends StatelessWidget {
  final String? itemNo;

  InventoryRecordView({this.itemNo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InventoryRecordFilterSection(initialItemNo: itemNo),
        Expanded(
          child: BlocBuilder<InventoryBloc, InventoryState>(
            builder: (context, state) {
              if (state is InventoryLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is InventoryLoaded) {
                return InventoryRecordListView(records: state.inventoryItems);
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
