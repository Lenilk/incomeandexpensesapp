import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stater with ChangeNotifier {
  List todo = [];
  DateTime selectDate = DateTime.now();

  String selectDateString() {
    return DateFormat("EEE วันที่ d MMM yyyy").format(selectDate);
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    notifyListeners();
  }
}
