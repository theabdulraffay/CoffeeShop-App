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

  static Future<void> modifyOrderQuantity(ObjectId order, int quantity) async {
    try {
      await ordersCollection.updateOne({
        'product_id': order
      }, {
        '\$inc': {'quantity': quantity}
      });
    } catch (e) {
      log('Error incrementing order quantity: ${e.toString()}',
          name: 'Order Error');
    }
  }

  //----------------------------------------------------------------------------------------

  static Future<void> deleteOrder(ObjectId id) async {
    await ordersCollection.deleteOne({'product_id': id});
  }

  //----------------------------------------------------------------------------------------

  static Future<bool> clearData() async {
    var res = await ordersCollection.drop();
    log('$res', name: 'clearData');
    return res;
  }
  //----------------------------------------------------------------------------------------

  static Future<void>? getTotal() async {
    try {
      var result = await ordersCollection.aggregate([
        {
          '\$lookup': {
            'from': "inventory", // The target collection to join with
            'localField': "product_id", // The field in the ordersCollection
            'foreignField': "_id", // The field in the inventory collection
            'as':
                "userProducts", // The name of the new array field containing matched documents
          },
        },
        {
          '\$unwind':
              "\$userProducts", // Optional: If you want a flat structure (one order per document)
        },
        {
          '\$project': {
            "product_name":
                "\$userProducts.product_name", // Accessing the joined field
            "product_price":
                "\$userProducts.product_price", // Accessing the joined field
            "quantity": 1, // Including fields from the orders collection
          },
        },
      ]);
      log('$result', name: 'Success');
    } catch (e) {
      log(e.toString(), name: 'Error');
    }
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
