import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:coremvp/modules/item.dart';
import 'package:coremvp/data/item_data.dart';
import 'package:coremvp/dependency_injection.dart';

class ItemForm extends StatefulWidget {
  @override
  ItemFormState createState() => new ItemFormState();
}

class ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final productNameCtl = TextEditingController();
  final retailPriceCtl = TextEditingController();
  final wholeSalePriceCtl = TextEditingController();
  ItemData _itemData;

  ItemFormState() {
    _itemData = new ItemData();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    @override
    void dispose() {
      productNameCtl?.dispose();
      retailPriceCtl?.dispose();
      wholeSalePriceCtl?.dispose();
      super.dispose();
    }

    return Scaffold(
        appBar: AppBar(title: Text("Form Item")),
        body: new Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Product Name",
                      icon: const Icon(Icons.create)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  controller: productNameCtl,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Retail Price",
                      icon: const Icon(Icons.create)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  controller: retailPriceCtl,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Wholesale Price",
                      icon: const Icon(Icons.create)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  controller: wholeSalePriceCtl,
                ),
                new Container(
                  width: screenSize.width,
                  child: RaisedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        Item _item = new Item(
                            "001",
                            productNameCtl.text.toString(),
                            "",
                            0,
                            int.parse(retailPriceCtl.text.toString(),
                                radix: 16),
                            int.parse(wholeSalePriceCtl.text.toString(),
                                radix: 16));
                        // If the form is valid
                        _itemData
                            .saveItem(_item)
                            .then(
                                (d) => Navigator.of(context).pushNamed("/item"))
                            .catchError((e) => print(e));
                      }
                    },
                    child: Text('Submit'),
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                )
              ],
            ),
          ),
        ));
  }
}
