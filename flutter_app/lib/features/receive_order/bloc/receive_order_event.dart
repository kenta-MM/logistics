import 'package:equatable/equatable.dart';

abstract class ReceiveOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadReceiveOrder extends ReceiveOrderEvent {}

class FetchOrders extends ReceiveOrderEvent {}

class FilterOrders extends ReceiveOrderEvent {
  final String selectedStatus;
  final String selectedSupplier;
  final String orderNoFilter;
  final String partsNoFilter;

  FilterOrders({
    required this.selectedStatus,
    required this.selectedSupplier,
    required this.orderNoFilter,
    required this.partsNoFilter,
  });

  @override
  List<Object> get props =>
      [selectedStatus, selectedSupplier, orderNoFilter, partsNoFilter];
}

class ChangePage extends ReceiveOrderEvent {
  final int newPage;

  ChangePage({required this.newPage});

  @override
  List<Object> get props => [newPage];
}
