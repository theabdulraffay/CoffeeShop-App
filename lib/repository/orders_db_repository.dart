import 'package:coffeeshopapp/Mongo/mongo_server.dart';
import 'package:coffeeshopapp/models/order_model.dart';

class OrdersDbRepository {
  Future<void> addOrder(OrderModel model) async {
    var result = {
      'product_id': model.product.id,
      'quantity': model.orderAmount,
    };
    await MongoServer.addOrder(result);
  }

  Future<void> incrementQuantity(OrderModel model) async {
    await MongoServer.modifyOrderQuantity(model.product.id!, 1);
  }

  Future<void> decrementQuantity(OrderModel model) async {
    await MongoServer.modifyOrderQuantity(model.product.id!, -1);
  }
}
