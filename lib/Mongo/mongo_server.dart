// import 'dart:developer';
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

class MongoServer {
  static late Db db;
  static late DbCollection userCollection;
  static late DbCollection ordersCollection;

  //----------------------------------------------------------------------------------------

  static Future<void> connect() async {
    try {
      db = Db('mongodb://localhost:27017/coffee_app');
      await db.open();
      log('db.isConnected: ${db.isConnected}',
          name: 'MongoServer', time: DateTime.now());
      userCollection = db.collection('inventory');
      ordersCollection = db.collection('orders');
    } catch (e) {
      log("Error: $e");
    }
  }

  //----------------------------------------------------------------------------------------
  static Stream<Map<String, dynamic>> getAllMovies() => userCollection.find();

  //----------------------------------------------------------------------------------------

  static Future<void> insertOne(Map<String, dynamic> data) async {
    try {
      await userCollection.insertOne(data);
    } catch (e) {
      log('Insert error: ${e.toString()}', name: 'MongoServer');
    }
  }

  //----------------------------------------------------------------------------------------

  static Future<void>? addOrder(Map<String, dynamic> map) async {
    try {
      await ordersCollection.insertOne(map);
    } catch (e) {
      log('Error adding order ${e.toString()}', name: 'Order Error');
    }
  }

  //----------------------------------------------------------------------------------------

  static Future<void>? getTotal() async {
    var result = await userCollection.aggregate([
      {
        '\$lookup': {
          'from': 'orders',
          "localField": "_id",
          "foreignField": "new_id",
          "as": "userProducts"
        },
      },
      {
        "\$project": {
          "product_name": 1,
          "product_price": 1,
        },
      }
    ]);
    print(result);
  }
  // static Future<void> close() async {
  //   if (db != null && db!.isConnected) {
  //     try {
  //       await db?.close();
  //       log('Database connection closed', name: 'MongoServer');
  //     } catch (e) {
  //       log('Close error: ${e.toString()}', name: 'MongoServer');
  //     }
  //   } else {
  //     log('Database was not connected', name: 'MongoServer');
  //   }
  // }
}
