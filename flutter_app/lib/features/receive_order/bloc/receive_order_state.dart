import 'package:equatable/equatable.dart';
import 'package:logistics/features/receive_order/models/receive_order.dart';

abstract class ReceiveOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrdersInitial extends ReceiveOrderState {}

class OrdersLoading extends ReceiveOrderState {}

class OrdersLoaded extends ReceiveOrderState {
  final List<ReceiveOrder> orders;
  final int currentPage;
  final int totalPages;

  OrdersLoaded({
    required this.orders,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  List<Object> get props => [orders, currentPage, totalPages];
}

class OrdersLoadFailure extends ReceiveOrderState {
  final String error;

  OrdersLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}