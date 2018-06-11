import 'dart:async';

import 'package:coremvp/data/database_helper.dart';
import 'package:coremvp/modules/product.dart';

class ProductData implements ProductRepository {
  DatabaseHelper dbClass = new DatabaseHelper();

  @override
  Future<int> saveProduct(Product product) async {
    var _dbClient = await dbClass.db;
    int res = await _dbClient.insert("Product", product.toMap());
    return res;
  }

  @override
  Future<List<Product>> fetchProduct() async {
    // TODO: implement fetchProduct
    var _dbClient = await dbClass.db;
    var list = await _dbClient.query("Product");
    return list.map((c) => new Product.fromMap(c)).toList();
  }

  @override
  Future<int> removeProduct() async {
    // TODO: implement removeProduct

    var _dbClient = await dbClass.db;
    int res = await _dbClient.delete("Product");
    return res;
  }

  @override
  Future<bool> updateProduct() async {
    // TODO: implement updateProduct
    return true;
  }
}
