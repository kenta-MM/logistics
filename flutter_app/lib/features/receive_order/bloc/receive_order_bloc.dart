// lib/features/receive_order/bloc/receive_order_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/receive_order_repository.dart';
import 'receive_order_event.dart';
import 'receive_order_state.dart';

class ReceiveOrderBloc extends Bloc<ReceiveOrderEvent, ReceiveOrderState> {
  final ReceiveOrderRepository receiveOrderRepository;
  static const int itemsPerPage = 100;

  ReceiveOrderBloc(this.receiveOrderRepository) : super(OrdersInitial()) {
    on<FetchOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final orders = await receiveOrderRepository.loadOrders();
        emit(OrdersLoaded(
          orders: orders.take(itemsPerPage).toList(),
          currentPage: 0,
          totalPages: (orders.length / itemsPerPage).ceil(),
        ));
      } catch (e) {
        emit(OrdersLoadFailure(e.toString()));
      }
    });

    on<FilterOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final filteredOrders = await receiveOrderRepository.filterOrders(
          event.selectedStatus,
          event.selectedSupplier,
          event.orderNoFilter,
          event.partsNoFilter,
        );
        emit(OrdersLoaded(
          orders: filteredOrders.take(itemsPerPage).toList(),
          currentPage: 0,
          totalPages: (filteredOrders.length / itemsPerPage).ceil(),
        ));
      } catch (e) {
        emit(OrdersLoadFailure(e.toString()));
      }
    });

    on<ChangePage>((event, emit) async {
      final currentState = state as OrdersLoaded;
      try {
        final paginatedOrders = await receiveOrderRepository.paginateOrders(
          event.newPage * itemsPerPage,
          itemsPerPage,
        );
        emit(OrdersLoaded(
          orders: paginatedOrders,
          currentPage: event.newPage,
          totalPages: currentState.totalPages,
        ));
      } catch (e) {
        emit(OrdersLoadFailure(e.toString()));
      }
    });
  }
}
