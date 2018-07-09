import 'package:coremvp/modules/product.dart';
import 'package:coremvp/page/product/product_presentor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  @override
  ProductState createState() => new ProductState();
}

class ProductState extends State<ProductPage>
    implements ProductListViewContract {
  ProductListPresentor _presentor;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  List<Product> _product;
  bool _isLoading;

  ProductState() {
    _presentor = new ProductListPresentor(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presentor.loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Product"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _isLoading
          ? new Center(child: new CircularProgressIndicator())
          : _productWidget(),
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Drawer Header'),
              decoration: new BoxDecoration(
                color: Colors.blue,
              ),
            ),
            new ListTile(
              title: new Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _productWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: _product.length,
              itemBuilder: (BuildContext context, int index) {
                final Product product = _product[index];
                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUi(product, color);
              },
            ),
          )
        ],
      ),
    );
  }

  ListTile _getListItemUi(Product product, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(product.name[0].toString()),
      ),
      title: new Text(product.name,
          style:
              new TextStyle(fontWeight: FontWeight.bold, fontFamily: "osSys")),
      subtitle: _getSubTitleText(product.cost),
      isThreeLine: true,
    );
  }

  Widget _getSubTitleText(double cost) {
    TextSpan costChangeText = new TextSpan(text: "$cost");
    return new RichText(
      text: new TextSpan(children: [costChangeText]),
    );
  }

  @override
  void onLoadProductComplete(List<Product> items) {
    // TODO: implement onLoadProductComplete
    setState(() {
      _product = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadProductError() {
    // TODO: implement onLoadProductError
  }
}
