import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String username = '';

  void setUser(String username) {
    this.username = username;
    keepUserINSP(username);
    notifyListeners();
  }

  void keepUserINSP(String username) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('user', username);
  }
}
