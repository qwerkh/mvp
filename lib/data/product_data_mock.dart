import 'dart:async';

import 'package:coremvp/modules/product.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchProduct() {
    return new Future.value(product);
  }

  @override
  Future<int> removeProduct() async {
    // TODO: implement removeProduct
    return 1;
  }

  @override
  Future<int> saveProduct(Product product) async {
    // TODO: implement saveProduct
    return 1;
  }

  @override
  Future<bool> updateProduct() async {
    // TODO: implement updateProduct
    return true;
  }
}

var product = <Product>[
  new Product(
      name: "ABC", code: "001", cost: 20.0, rePrice: 30.0, whPrice: 28.0),
  new Product(
      name: "ANCHOR", code: "002", cost: 30.0, rePrice: 45.0, whPrice: 38.0),
  new Product(
      name: "ANGKOR", code: "003", cost: 40.0, rePrice: 50.0, whPrice: 48.0),
];
