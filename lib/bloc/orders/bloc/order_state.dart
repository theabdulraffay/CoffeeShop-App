part of 'order_bloc.dart';

class OrderState extends Equatable {
  final List<OrderModel> listOfOrders;
  final Status status;
  final String message;

  const OrderState({
    this.listOfOrders = const [],
    this.message = '',
    this.status = Status.initial,
  });

  OrderState copyWith({
    List<OrderModel>? listOfOrders,
    String? message,
    Status? status,
  }) {
    return OrderState(
      listOfOrders: listOfOrders ?? this.listOfOrders,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [message, listOfOrders, status];
}
