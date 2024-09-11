// lib/features/receive_order/models/receive_order.dart

import 'package:equatable/equatable.dart';

class ReceiveOrder extends Equatable {
  final String sendOrderSupplier;
  final String receiveOrderSupplier;
  final String orderNo;
  final String partsNo;
  final String partsName;
  final String receiveOrderDate;
  final int receiveNum;
  final int unitPrice;
  final int totalPrice;
  final String orderStatus;
  final String shipmentDate;

  ReceiveOrder({
    required this.sendOrderSupplier,
    required this.receiveOrderSupplier,
    required this.orderNo,
    required this.partsNo,
    required this.partsName,
    required this.receiveOrderDate,
    required this.receiveNum,
    required this.unitPrice,
    required this.totalPrice,
    required this.orderStatus,
    required this.shipmentDate,
  });

  @override
  List<Object> get props => [
        sendOrderSupplier,
        receiveOrderSupplier,
        orderNo,
        partsNo,
        partsName,
        receiveOrderDate,
        receiveNum,
        unitPrice,
        totalPrice,
        orderStatus,
        shipmentDate,
      ];

  // JSONデータのパースに便利なファクトリメソッド
  factory ReceiveOrder.fromJson(Map<String, dynamic> json) {
    return ReceiveOrder(
      sendOrderSupplier: json['send_order_supplier'],
      receiveOrderSupplier: json['receive_order_supplier'],
      orderNo: json['order_no'],
      partsNo: json['parts_no'],
      partsName: json['parts_name'],
      receiveOrderDate: json['receive_order_date'],
      receiveNum: json['receive_num'],
      unitPrice: json['unit_price'],
      totalPrice: json['total_price'],
      orderStatus: json['order_status'],
      shipmentDate: json['shipment_date'],
    );
  }

  // オブジェクトをJSONに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'send_order_supplier': sendOrderSupplier,
      'receive_order_supplier': receiveOrderSupplier,
      'order_no': orderNo,
      'parts_no': partsNo,
      'parts_name': partsName,
      'receive_order_date': receiveOrderDate,
      'receive_num': receiveNum,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'order_status': orderStatus,
      'shipment_date': shipmentDate,
    };
  }
}
