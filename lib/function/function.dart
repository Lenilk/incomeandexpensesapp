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
    formatToyMEd(DateTime(2022)): ["Meaw"],
  };
  List<DateTime> dateMark = [];

  String selectDateString() {
    return DateFormat("EEE วันที่ d MMM yyyy").format(selectDate);
  }

  bool isSelectDayAvailable() {
    return isSelectDayAvailablefn(formatToyMEd(selectDate));
  }

  void addDateAndData(String date, dataAdd) {
    data = {
      ...data,
      date: [dataAdd]
    };
    dateMark.add(DateFormat.yMEd().parse(date));
    notifyListeners();
  }

  void addDataInDate(String date, dataAdd) {
    data[date]?.add(dataAdd);
    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    notifyListeners();
  }
}
