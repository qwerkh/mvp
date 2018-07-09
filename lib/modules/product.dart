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
        cost = double.parse(
            map['cost'].toString() == "null" ? "0" : map['cost'].toString()),
        rePrice = double.parse(
            map['rePrice'].toString() == "null" ? "0" : map['rePrice'].toString()),
        whPrice = double.parse(
            map['whPrice'].toString() == "null" ? "0" : map['whPrice'].toString());

  Map<String, dynamic> toMap() {
    var _map = new Map<String, dynamic>();
    _map["name"] = name;
    _map["code"] = code;
    _map["cost"] = double.parse(cost.toString() == "null" ? "0" : cost.toString());
    _map["rePrice"] =
        double.parse(rePrice.toString() == "null" ? "0" : rePrice.toString());
    _map["whPrice"] =
        double.parse(whPrice.toString() == "null" ? "0" : whPrice.toString());
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
