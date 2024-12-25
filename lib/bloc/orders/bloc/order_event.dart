part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrderEvent extends OrderEvent {
  final ProductModel productModel;
  const AddOrderEvent({required this.productModel});
}

class ClearOrderEvent extends OrderEvent {}

class IncrementOrderEvent extends OrderEvent {
  final OrderModel orderModel;
  const IncrementOrderEvent({required this.orderModel});
}

class DecrementOrderEvent extends OrderEvent {
  final OrderModel orderModel;
  const DecrementOrderEvent({required this.orderModel});
}

class RemoveOrder extends OrderEvent {
  final OrderModel orderModel;
  const RemoveOrder({required this.orderModel});
}
