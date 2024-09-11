// lib/features/receive_order/repository/receive_order_repository.dart

import 'dart:math';
import 'package:logistics/features/common/repositories/api_repository.dart';

import '../models/receive_order.dart';

class ReceiveOrderRepository {
  final ApiRepository apiRepository;

  ReceiveOrderRepository({required this.apiRepository});
  
  final List<ReceiveOrder> _orders = _generateOrders();

  static List<ReceiveOrder> _generateOrders() {
    final random = Random();
    final suppliers = [
      '部品製造会社A',
      '部品製造会社B',
      '部品製造会社C',
      '部品製造会社D',
      '部品製造会社E'
    ];
    final statuses = ['新規', '処理中', '発送済み', '完了', 'キャンセル'];

    return List.generate(1000, (index) {
      final sendOrderSupplier = suppliers[random.nextInt(suppliers.length)];
      String receiveOrderSupplier = 'トラック製造会社A';
      final orderNo = (index + 1).toString().padLeft(7, '0');
      final partsNo = 'AAAAAA${(index % 10 + 1).toString().padLeft(2, '0')}';
      final partsName = 'ボルトAAAA${index % 10 + 1}';
      final receiveOrderDate =
          '2024-05-${(index % 31 + 1).toString().padLeft(2, '0')}';
      final receiveNum = (index % 100 + 1) * 100;
      int unitPrice = 10000;
      final totalPrice = receiveNum * unitPrice;
      final orderStatus = statuses[random.nextInt(statuses.length)];
      final shipmentDate = (orderStatus == '発送済み' || orderStatus == '完了')
          ? '2024-06-${(index % 30 + 1).toString().padLeft(2, '0')}'
          : '';

      return ReceiveOrder(
        sendOrderSupplier: sendOrderSupplier,
        receiveOrderSupplier: receiveOrderSupplier,
        orderNo: orderNo,
        partsNo: partsNo,
        partsName: partsName,
        receiveOrderDate: receiveOrderDate,
        receiveNum: receiveNum,
        unitPrice: unitPrice,
        totalPrice: totalPrice,
        orderStatus: orderStatus,
        shipmentDate: shipmentDate,
      );
    });
  }

  Future<List<ReceiveOrder>> loadOrders() async {
    return _orders;
  }

  Future<List<ReceiveOrder>> filterOrders(String status, String supplier, String orderNo, String partsNo) async {
    return _orders.where((order) {
      final matchesStatus = status.isEmpty || order.orderStatus == status;
      final matchesSupplier = supplier.isEmpty || order.sendOrderSupplier == supplier;
      final matchesOrderNo = orderNo.isEmpty || order.orderNo.contains(orderNo);
      final matchesPartsNo = partsNo.isEmpty || order.partsNo.contains(partsNo);

      return matchesStatus && matchesSupplier && matchesOrderNo && matchesPartsNo;
    }).toList();
  }

  Future<List<ReceiveOrder>> paginateOrders(int startIndex, int itemsPerPage) async {
    return _orders.skip(startIndex).take(itemsPerPage).toList();
  }
}
