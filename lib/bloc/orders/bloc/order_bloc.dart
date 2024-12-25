import 'dart:developer';

import 'package:coffeeshopapp/models/order_model.dart';
import 'package:coffeeshopapp/models/product_model.dart';
import 'package:coffeeshopapp/repository/orders_db_repository.dart';
import 'package:coffeeshopapp/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrdersDbRepository ordersDbRepository = OrdersDbRepository();
  List<OrderModel> orders;

  OrderBloc({this.orders = const []}) : super(const OrderState()) {
    on<AddOrderEvent>(_addOrder);
    on<ClearOrderEvent>(_clearOrder);
    on<IncrementOrderEvent>(_incrementOrder);
    on<DecrementOrderEvent>(_decrementOrder);
    on<RemoveOrder>(_removeOrder);
  }

  void _addOrder(AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    var avalible = orders.isNotEmpty &&
        orders.any((val) => val.product == event.productModel);
    // var avalible = false;
    log('$avalible');
    if (avalible) {
      emit(state.copyWith(
        status: Status.avalible,
        message: 'Product already added to the cart',
      ));
      return;
    }
    orders = [...state.listOfOrders, OrderModel(product: event.productModel)];
    await ordersDbRepository.addOrder(orders.last).then((val) {
      emit(state.copyWith(
        status: Status.success,
        listOfOrders: orders,
        message: 'Order added successfully',
      ));
    }).catchError((error) {
      emit(state.copyWith(
        status: Status.error,
        message: error.toString(),
      ));
    });
  }

  void _clearOrder(ClearOrderEvent event, Emitter<OrderState> emit) async {
    orders = const [];
    await ordersDbRepository.clearDatabase().then((val) {
      emit(state.copyWith(
        status: val ? Status.success : Status.error,
        listOfOrders: orders,
        message: val ? 'Database cleared successfully' : 'Database not found',
      ));
    }).catchError((e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    });
  }

  void _incrementOrder(
      IncrementOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: Status.loading));
    orders[orders.indexOf(event.orderModel)] = event.orderModel;
    await ordersDbRepository.incrementQuantity(event.orderModel).then((val) {
      emit(state.copyWith(
          status: Status.success, message: 'Success', listOfOrders: orders));
    }).catchError((e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    });
  }

  void _decrementOrder(
      DecrementOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: Status.loading));
    orders[orders.indexOf(event.orderModel)] = event.orderModel;

    await ordersDbRepository.decrementQuantity(event.orderModel).then((val) {
      emit(state.copyWith(
          status: Status.success, message: 'Success', listOfOrders: orders));
    }).catchError((e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    });
  }

  void _removeOrder(RemoveOrder event, Emitter<OrderState> emit) async {
    orders.remove(event.orderModel);
    orders.remove(event.orderModel);
    await ordersDbRepository.deleteOrder(event.orderModel).then((val) {
      emit(state.copyWith(
          status: Status.success, message: 'Success', listOfOrders: orders));
    }).catchError((e) {
      emit(state.copyWith(status: Status.error, message: e.toString()));
    });
  }
}
