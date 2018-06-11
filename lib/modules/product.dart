import 'dart:async';

class Product {
  String name;
  String code;
  double cost;
  double rePrice;
  double whPrice;

  Product({this.name, this.code, this.cost, this.rePrice, this.whPrice});
  Product.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        code = map['code'],
        cost = map['cost'],
        rePrice = map['rePrice'],
        whPrice = map['whPrice'];

  Map<String, dynamic> toMap() {
    var _map = new Map<String, dynamic>();
    _map["name"] = name;
    _map["code"] = code;
    _map["cost"] = cost;
    _map["rePrice"] = rePrice;
    _map["whPrice"] = whPrice;
    return _map;
  }
}

abstract class ProductRepository {
  Future<List<Product>> fetchProduct();
  Future<int> saveProduct(Product product);
  Future<bool> updateProduct();
  Future<int> removeProduct();
}

class FetchDataException implements Exception {
  final _message;
  FetchDataException([this._message]);
  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
