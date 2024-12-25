import 'package:coffeeshopapp/models/product_model.dart';

// More Complex model can be created here
class OrderModel {
  ProductModel product;
  int orderAmount = 0;

  OrderModel({required this.product, this.orderAmount = 1});

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'order_amount': orderAmount,
    };
  }

  // Create OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      product: ProductModel.fromJson(json['product']),
      orderAmount: json['order_amount'] ?? 0,
    );
  }
}

// List<OrderModel> orderList = [];
