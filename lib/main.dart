import 'package:coremvp/page/home.dart';
import 'package:coremvp/page/item/item.dart';
import 'package:coremvp/page/login/login.dart';
import 'package:coremvp/page/product/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:coremvp/dependency_injection.dart';

void main() {
  Injector.configure(Flavor.Prod);
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

final _route = <String, WidgetBuilder>{
  "/product": (BuildContext context) => new ProductPage(),
  "/": (BuildContext context) => new ItemPage(),
  "/login": (BuildContext context) => new LoginPage(),
  "/home": (BuildContext context) => new HomePage(title: "Home Page"),
  "/item": (BuildContext context) => new ItemPage(),
};

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter MVP',
      theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.blue,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[100]
              : null),
      routes: _route,
    );
  }
}
