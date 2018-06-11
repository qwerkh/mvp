import 'dart:async';

import 'package:coremvp/dependency_injection.dart';
import 'package:coremvp/modules/user.dart';

class RestData {
  //Injector _inj = new Injector();
  //static final Base_Url = "";
  //static final Login_Url = Base_Url + "/";

  Future<User> login(String username, String password) {
    return new Future.value(new User(username, password));
  }
}
