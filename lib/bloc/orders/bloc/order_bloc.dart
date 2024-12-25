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
  late List<OrderModel> orders;

  OrderBloc() : super(const OrderState()) {
    on<AddOrderEvent>(_addOrder);
  }

  void _addOrder(AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
    ));
    orders = [...state.listOfOrders, OrderModel(product: event.productModel)];
    await ordersDbRepository.addOrder(orders.last).then((val) {
      emit(state.copyWith(
        status: Status.success,
        listOfOrders: orders,
      ));
    }).catchError((error) {
      emit(state.copyWith(
        status: Status.error,
        message: error.toString(),
      ));
    });
  }
}
