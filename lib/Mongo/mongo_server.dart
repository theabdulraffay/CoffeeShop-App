// import 'dart:developer';
import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

String host = '127.0.0.1';
String port = '27017';

class MongoServer {
  static late Db db;
  static late DbCollection userCollection;
  static late DbCollection ordersCollection;
  static Future<void> connect() async {
    try {
      db = Db('mongodb://localhost:27017/coffee_app');
      await db.open();
      print(db.isConnected);
      userCollection = db.collection('inventory');
      ordersCollection = db.collection('orders');
      print('hehe');
      // var da = (await userCollection.find().first);
      // print(da);
      // userCollection.insertOne({
      //   'name': 'Americano',
      //   'price': 3.79,
      //   'rating': 4.3,
      // });
      // userCollection.deleteOne({'name': 'Americano'});
      // userCollection.find().forEach((map) {
      //   print(map);
      // });
      // print(userCollection);
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> insertOne([var db, Map<String, dynamic>? data]) async {
    // if (db == null || !db.isConnected) {
    //   log('Database is not connected. Call connect() first.',
    //       name: 'MongoServer');
    //   return;
    // }
    // userCollection = db.collection('inventory');

    try {
      userCollection.find().forEach((map) {
        print(map);
      });
      // userCollection.aggregate([
      //   {
      //     "\$lookup": {
      //       "from": "products",
      //       "localField": "userId",
      //       "foreignField": "userId",
      //       "as": "userProducts"
      //     }
      //   }
      // ]);
      // var result = await userCollection.insertOne(data);
      // log('Insert result: $result', name: 'MongoServer');
    } catch (e) {
      log('Insert error: ${e.toString()}', name: 'MongoServer');
    }
  }

  static Future<void>? addOrder() async {
    userCollection.find().forEach((map) async {
      await ordersCollection.insertOne({
        'new_id': map['_id'] as ObjectId,
        'name': map['product_name'],
      });
    });
  }

  static Future<void>? getTotal() async {
    int total = 0;
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
