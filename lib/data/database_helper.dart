import 'package:coremvp/modules/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();
  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "test4.db");
    print("Want Create db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    print(ourDb);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT,password TEXT)");
    print("Table User");

    await db.execute(
        "CREATE TABLE Item(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,code TEXT,cost INTEGER,rePrice INTEGER,whPrice INTEGER)");
    print("Table Item");
  }

  //Insert
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //Delete
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
}
