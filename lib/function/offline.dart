import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:incomeandexpensesapp/jsonserialization/offline.dart';
import 'package:incomeandexpensesapp/jsonserialization/offlineupdate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Offline with ChangeNotifier {
  List<String> offlineData = [];
  void addOfflineDataPostORDelete(
      String user, String date, type, Note data) async {
    final pref = await SharedPreferences.getInstance();
    offlineData.add(json.encode(OfflineData(user, date, data, type).toJson()));
    pref.setString('offlineData', json.encode(offlineData));
    notifyListeners();
  }

  void addOfflineDataUpdate(String user, date, Note data, olddata) async {
    final pref = await SharedPreferences.getInstance();
    offlineData.add(json.encode(
        OfflineUpdateData(user, date, data, olddata, 'update').toJson()));
    pref.setString('offlineData', json.encode(offlineData));
    notifyListeners();
  }

  void deleteOfflineData(Map<String, dynamic> data) async {
    final pref = await SharedPreferences.getInstance();
    offlineData.remove(json.encode(data));
    pref.setString('offlineData', json.encode(offlineData));
    notifyListeners();
  }
}
