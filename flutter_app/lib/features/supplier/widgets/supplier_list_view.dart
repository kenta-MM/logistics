import 'package:flutter/material.dart';
import 'package:logistics/features/supplier/models/supplier.dart';
import 'package:logistics/features/supplier/screens/supplier_detail_screen.dart';
import 'package:logistics/features/supplier/screens/supplier_form_screen.dart';

class SupplierListView extends StatelessWidget {
  final List<Supplier> suppliers;

  SupplierListView({required this.suppliers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ヘッダー
        Container(
          color: Colors.grey[300], // ヘッダーの背景色
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Expanded(child: Text('サプライヤ名', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('メールアドレス', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        // サプライヤ一覧
        Expanded(
          child: ListView.builder(
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final supplier = suppliers[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupplierDetailScreen(supplier: supplier),
                    ),
                  );
                },
                child: Container(
                  // color: index % 2 == 0 ? Colors.white : Colors.grey[200], // 交互に背景色を変える
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(supplier.name)),
                        Expanded(child: Text(supplier.contactEmail)),
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
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
