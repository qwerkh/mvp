import 'dart:async';

import 'package:coremvp/data/item_data.dart';
import 'package:coremvp/data/product_data_mock.dart';
import 'package:coremvp/data/product_data_prod.dart';
import 'package:coremvp/modules/item.dart';
import 'package:coremvp/modules/product.dart';

enum Flavor { Mock, Prod }
//DI

class Injector {
  static final Injector _singleTon = new Injector._internal();
  static Flavor _flavor;
  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleTon;
  }
  Injector._internal();

  Future<dynamic> get() {
    return null;
  }

  ProductRepository get productRepository {
    switch (_flavor) {
      case Flavor.Mock:
        return new MockProductRepository();
      default:
        return new ProdProductRepository();
    }
  }

  ItemRepository get itemRepository {
    switch (_flavor) {
      case Flavor.Mock:
        return new ItemData();
      default:
        return new ItemData();
    }
  }
}
