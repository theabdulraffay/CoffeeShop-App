import 'package:coffeeshopapp/Mongo/mongo_server.dart';
import 'package:coffeeshopapp/models/product_model.dart';

class ProductModelDbReposiotry {
  Future<List<ProductModel>?> getProductModels() async {
    // Fetch data from database
    var result = MongoServer.getAllMovies();
    return await result.map((map) {
      return ProductModel.fromJson(map);
    }).toList();
  }

  Future<void> addProductModel(ProductModel productModel) async {
    await MongoServer.insertOne(productModel.toJson());
    // Add data to database
  }
}
