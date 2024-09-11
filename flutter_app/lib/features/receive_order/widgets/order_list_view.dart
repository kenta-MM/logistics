import 'package:flutter/material.dart';
import 'package:logistics/features/receive_order/models/receive_order.dart';

class OrderListView extends StatelessWidget {
  final List<ReceiveOrder> orders;

  OrderListView({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ヘッダーを表示するためのRowウィジェット
        Container(
          color: const Color.fromARGB(255, 229, 226, 226), // ヘッダーの背景色
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Expanded(child: Text('得意先サプライヤ', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('仕入先サプライヤ', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('発注注番', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('品番', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('品名', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('受注日', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('受注数', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('受注単価', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('受注合計額', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('受注ステータス', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text('発送日', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        // ListView.builderで受注一覧を表示
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return GestureDetector(
                child: Container(
                  color: order.orderStatus == '完了'
                      ? const Color.fromARGB(255, 168, 249, 171)
                      : order.orderStatus == 'キャンセル'
                          ? const Color.fromARGB(255, 196, 196, 196)
                          : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(order.sendOrderSupplier)),
                        Expanded(child: Text(order.receiveOrderSupplier)),
                        Expanded(child: Text(order.orderNo)),
                        Expanded(child: Text(order.partsNo)),
                        Expanded(child: Text(order.partsName)),
                        Expanded(child: Text(order.receiveOrderDate)),
                        Expanded(child: Text(order.receiveNum.toString())),
                        Expanded(child: Text(order.unitPrice.toString())),
                        Expanded(child: Text(order.totalPrice.toString())),
                        Expanded(child: Text(order.orderStatus)),
                        Expanded(child: Text(order.shipmentDate)),
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
