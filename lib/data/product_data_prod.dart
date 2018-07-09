import 'dart:async';
import 'package:coremvp/modules/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;


class ProdProductRepository implements ProductRepository {
  final WebSocketChannel channel;

  //String productUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  String productUrl = "http://192.168.0.118:3000/methods/api_fetchProduct";

  @override
  Future<List<Product>> fetchProduct() async {
    //http.Response response = await http.get(productUrl);
    // http.Response response = await http
    //     .post(productUrl);
    final JsonDecoder _decode = JsonDecoder();
    // final List responeBody = _decode.convert(response.body);
    // final statusCode = response.statusCode;
    // print(response);
    // if (statusCode != 200 || responeBody == null) {
    //   throw new FetchDataException(
    //       "An Error occured : [Status Code : $statusCode]");
    // }

    // return responeBody.map((c) => new Product.fromMap(c)).toList();
    var client = http.Client();
    client.post(productUrl,headers: {
      "Content-Type" : "application/json; charset=UTF-8"

    })
    .then((response){
      print(response.body);
    });
    return [];
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
