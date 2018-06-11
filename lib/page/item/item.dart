import 'dart:convert';

import 'package:coremvp/data/item_data.dart';
import 'package:coremvp/modules/item.dart';
import 'package:coremvp/page/item/item_presenter.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  @override
  ItemState createState() => new ItemState();
}

class ItemState extends State<ItemPage> implements ItemContract {
  ItemPresenter _presenter;
  ItemRepository _repository;
  ItemData _itemData;
  List<Item> _item;
  bool _isLoading = false;

  ItemState() {
    _presenter = new ItemPresenter(this);
    _itemData = new ItemData();
  }

  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
      _presenter.loadItem();
    });
  }

  void _addItem() {
    Item item = new Item("001","Test3", "uu2", 200, 400, 900);
    _itemData.saveItem(item).then((d) => print(d)).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Item Page"),
      ),
      body: _isLoading == true
          ? new Center(child: new CircularProgressIndicator())
          : _itemWidget(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addItem,
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _itemWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: _item.length,
              itemBuilder: (BuildContext context, int index) {
                final Item item = _item[index];
                return _getListItemUi(item);
              },
            ),
          )
        ],
      ),
    );
  }

  ListTile _getListItemUi(Item item) {
    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(item.name[0]),
      ),
      title: new Text(
        item.name,
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: new Text(item.rePrice.toString()),
    );
  }

  @override
  void onLoadError(String error) {
    // TODO: implement onLoadError
  }

  @override
  void onLoadItemSuccess(List<Item> item) {
    setState(() {
      _item = item;
      _isLoading = false;
    });
  }
}
