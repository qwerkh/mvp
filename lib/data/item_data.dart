import 'dart:async';

import 'package:coremvp/data/database_helper.dart';
import 'package:coremvp/modules/item.dart';

class ItemData implements ItemRepository {
  DatabaseHelper dbClass = new DatabaseHelper();
  @override
  Future<List<Item>> fetchItem() async {
    var _dbClient = await dbClass.db;
    var res = await _dbClient.rawQuery("SELECT * FROM Item");
    return res.map((c) => new Item.fromMap(c)).toList();
  }

  @override
  Future<int> removeItem(String id) async {
    var _dbClient = await dbClass.db;
    var res = await _dbClient.rawDelete("DELETE FROM Item WHERE id= ? ", [id]);
    return res;
  }

  @override
  Future<int> saveItem(Item item) async {
    var _dbClient = await dbClass.db;
    var res = await _dbClient.rawInsert(
        "INSERT INTO Item (name,code,cost,rePrice,whPrice) VALUES(${item.name.toString()},${item.code.toString()},${item.cost},${item.rePrice},${item.whPrice})");
    print("Insert Success");
    return res;
  }

  @override
  Future<int> updateItem(Item item) async {
    var _dbClient = await dbClass.db;
    var res = await _dbClient.rawUpdate(
        "UPDATE Item SET name=?,code=?,cost=?,rePrice=?,whPrice=? WHERE id=?",
        [item.name, item.code, item.code, item.rePrice, item.whPrice, item.id]);
    return res;
  }
}
