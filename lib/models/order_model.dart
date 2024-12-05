import 'package:coffeeshopapp/models/product_model.dart';

// More Complex model can be created here
class OrderModel {
  ProductModel product;
  int orderAmount = 0;

  OrderModel({required this.product, required this.orderAmount});
}

List<OrderModel> orderList = [];
