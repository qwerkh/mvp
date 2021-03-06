import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:coremvp/tabs/home.dart';
import 'package:coremvp/page/item/item.dart';
import 'package:coremvp/page/item/item_form.dart';
import 'package:coremvp/page/login/login.dart';
import 'package:coremvp/page/product/product.dart';
import 'package:flutter/foundation.dart';

import 'package:coremvp/dependency_injection.dart';
import './tabs/home.dart' as _firstTab;
import './tabs/dashboard.dart' as _secondTab;
import './tabs/settings.dart' as _thirdTab;

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
  //"/": (BuildContext context) => new ItemPage(),
  "/login": (BuildContext context) => new LoginPage(),
  "/home": (BuildContext context) => new HomePage(title: "Home Page"),
  "/item": (BuildContext context) => new ItemPage(),
  "/itemForm": (BuildContext context) => new ItemForm(),
};

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter MVP',
      debugShowCheckedModeBanner:false,
      home: new Tabs(),
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
      //routes: _route,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/product':
            return new FromRightToLeft(
              builder: (_) => new ProductPage(),
              settings: settings,
            );
          case '/login':
            return new FromRightToLeft(
              builder: (_) => new LoginPage(),
              settings: settings,
            );
          case '/item':
            return new FromRightToLeft(
              builder: (_) => new ItemPage(),
              settings: settings,
            );
          case '/home':
            return new FromRightToLeft(
              builder: (_) => new HomePage(),
              settings: settings,
            );
          case '/itemForm':
            return new FromRightToLeft(
              builder: (_) => new ItemForm(),
              settings: settings,
            );
        }
      },
    );
  }
}

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 25.0,
          )
        ]),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(new CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      )),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  PageController _tabController;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(

      //App Bar
      appBar: new AppBar(
        title: new Text(
          _title_app,
          style: new TextStyle(
            fontSize:
                Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
          ),
        ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),

      //Content of tabs
      body: new PageView(
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          new _firstTab.HomePage(),
          new _secondTab.Dashboard(),
          new _thirdTab.Settings()
        ],
        
      ),
    

      //Tabs
      bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS
          ? new CupertinoTabBar(
              activeColor: Colors.blueGrey,
              currentIndex: _tab,
              onTap: onTap,
              items: TabItems.map((TabItem) {
                return new BottomNavigationBarItem(
                  title: new Text(TabItem.title),
                  icon: new Icon(TabItem.icon),
                );
              }).toList(),
            )
          : new BottomNavigationBar(
              currentIndex: _tab,
              onTap: onTap,
              
              items: TabItems.map((TabItem) {
                return new BottomNavigationBarItem(
                  title: new Text(TabItem.title),
                  icon: new Icon(TabItem.icon),
            
                );
              }).toList(),
            ),

      //Drawer
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new Container(
            height: 120.0,
            child: new DrawerHeader(
              padding: new EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: new Color(0xFFECEFF1),
              ),
              child: new Center(
                child: new FlutterLogo(
                  colors: Colors.blueGrey,
                  size: 54.0,
                ),
              ),
            ),
          ),
          new ListTile(
              leading: new Icon(Icons.chat),
              title: new Text('Product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/product');
              }),
          new ListTile(
              leading: new Icon(Icons.info),
              title: new Text('Login'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/login');
              }),
          new ListTile(
              leading: new Icon(Icons.shopping_basket),
              title: new Text('Item'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/item');
              }),
          new Divider(),
          new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      )));

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
        break;

      case 1:
        this._title_app = TabItems[1].title;
        break;

      case 2:
        this._title_app = TabItems[2].title;
        break;
    }
  }
}

class TabItem {
  const TabItem({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Home', icon: Icons.home),
  const TabItem(title: 'Dashboard', icon: Icons.dashboard),
  const TabItem(title: 'Settings', icon: Icons.settings)
];
