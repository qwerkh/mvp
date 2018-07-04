import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<HomePage> {
  final DocumentReference documentReference =
      Firestore.instance.collection("myData").document("dummy");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  String _myText;
  StreamSubscription<DocumentSnapshot> subscription;
  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    print("User Name: ${user.displayName}");
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Signout");
  }

  void _add() {
    Map<String, String> data = <String, String>{
      "name": "Narong",
      "desc": "Flutter Tester"
    };
    documentReference.setData(data).whenComplete(() {
      print("Add data");
    }).catchError((e) => print(e));
  }

  void _update() {
    Map<String, String> data = <String, String>{
      "name": "Data",
      "desc": "Flutter Ddd"
    };
    documentReference.updateData(data).whenComplete(() {
      print("Update Data");
    }).catchError((e) => print(e));
  }

  void _remove() {
    documentReference.delete().whenComplete(() {
      setState(() {
        _myText = "";
      });
      print("Delete Successfuly");
    }).catchError((e) => print(e));
  }

  void _fetch() {
    documentReference.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          _myText = dataSnapshot.data['desc'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((dataSnapshot) {
      if (dataSnapshot.exists) {
        setState(() {
          _myText = dataSnapshot.data['desc'];
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              onPressed: () => _signIn()
                  .then((FirebaseUser user) => print(user))
                  .catchError((e) => print(e)),
              child: new Text("Sign In"),
              color: Colors.green,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _signOut(),
              child: new Text("Sign Out"),
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _add(),
              child: new Text("Add"),
              color: Colors.lightBlue,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _update(),
              child: new Text("Update"),
              color: Colors.orange,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _remove(),
              child: new Text("Remove"),
              color: Colors.limeAccent,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _fetch(),
              child: new Text("Fetch"),
              color: Colors.cyanAccent,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            _myText == null
                ? new Container()
                : new Text(
                    _myText,
                    style: new TextStyle(fontSize: 20.0),
                  ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _onPressed(),
              child: new Text("Product"),
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }

  /* Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              onPressed: () => _signIn()
                  .then((FirebaseUser user) => print(user))
                  .catchError((e) => print(e)),
              child: new Text("Sign In"),
              color: Colors.green,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _signOut(),
              child: new Text("Sign Out"),
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _add(),
              child: new Text("Add"),
              color: Colors.lightBlue,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _update(),
              child: new Text("Update"),
              color: Colors.orange,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _remove(),
              child: new Text("Remove"),
              color: Colors.limeAccent,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _fetch(),
              child: new Text("Fetch"),
              color: Colors.cyanAccent,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            _myText == null
                ? new Container()
                : new Text(
                    _myText,
                    style: new TextStyle(fontSize: 20.0),
                  ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: () => _onPressed(),
              child: new Text("Product"),
              color: Colors.blueGrey,
            )
          ],
        ),
      ),
    );
  }
 */
  void _onPressed() {
    Navigator.of(context).pushNamed("/product");
  }
}
