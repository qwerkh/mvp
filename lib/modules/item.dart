import 'dart:async';

class Item {
  String id;
  String name;
  String code;
  int cost;
  int rePrice;
  int whPrice;

  Item(this.id, this.name, this.code, this.cost, this.rePrice, this.whPrice);

  Item.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        cost = map['cost'],
        code = map['code'],
        rePrice = map['rePrice'],
        whPrice = map['whPrice'];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['code'] = code;
    map['cost'] = cost;
    map['rePrice'] = rePrice;
    map['whPrice'] = whPrice;
    map['id'] = id;
    return map;
  }
}

abstract class ItemRepository {
  Future<List<Item>> fetchItem();
  Future<int> saveItem(Item item);
  Future<int> removeItem(String id);
  Future<int> updateItem(Item item);
}
