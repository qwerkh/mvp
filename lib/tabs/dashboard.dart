import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Card(
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Icon(Icons.dashboard, size: 150.0, color: Colors.black12),
              new Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/e/ed/Seneca-nature-trail_-_West_Virginia_-_ForestWander.jpg')
            ]),
      );
}
