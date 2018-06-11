import 'dart:async';
import 'package:coremvp/modules/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdProductRepository implements ProductRepository {
  final WebSocketChannel channel;

  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  @override
  Future<List<Product>> fetchProduct() async {
    http.Response response = await http.get(cryptoUrl);
    final List responeBody = JSON.decode(response.body);
    final statusCode = response.statusCode;

    if (statusCode != 200 || responeBody == null) {
      throw new FetchDataException(
          "An Error occured : [Status Code : $statusCode]");
    }

    return responeBody.map((c) => new Product.fromMap(c)).toList();
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
