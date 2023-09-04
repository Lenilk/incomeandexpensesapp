import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import './extension.dart';

class Stater with ChangeNotifier {
  List todo = [];
  DateTime selectDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  Map<String, List> data = {
    formatToyMEd(DateTime.now()): ["Meaw"],
  };

  List<DateTime> dateMark = [
    DateFormat.yMEd().parse(formatToyMEd(DateTime.now())),
    DateTime(2023)
  ];

  String selectDateString() {
    return DateFormat("EEE วันที่ d MMM yyyy").format(selectDate);
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    notifyListeners();
  }
}
