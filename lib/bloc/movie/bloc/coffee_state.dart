part of 'coffee_bloc.dart';

class CoffeeState extends Equatable {
  final List<ProductModel> products;
  final String message;
  final Status status;
  const CoffeeState({
    this.products = const [],
    this.message = '',
    this.status = Status.initial,
  });

  CoffeeState copyWith({
    List<ProductModel>? products,
    String? message,
    Status? status,
  }) {
    return CoffeeState(
      products: products ?? this.products,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [products, message, status];
}
