import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import './extension.dart';

class Stater with ChangeNotifier {
  List todo = [];
  DateTime selectDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  List<Map<String, dynamic>> data = [
    // {
    //   "Date": formatToyMEd(DateTime.now()),
    //   "data": [
    //     {"info": "Meaw", "amount": "5"}
    //   ]
    // }
  ];
  List<DateTime> dateMark = [];
  int whereday = 0;
  String selectDateTitle() {
    return DateFormat("EEE วันที่ d MMM yyyy").format(selectDate);
  }

  String selectDateString() {
    return formatToyMEd(selectDate);
  }

  bool isSelectDayAvailable() {
    return isSelectDayAvailablefn(formatToyMEd(selectDate));
  }

  void addDateAndData(String date, Map<String, String> dataAdd) {
    data.add({
      "Date": date,
      "data": [dataAdd]
    });
    dateMark.add(DateFormat.yMd().parse(date));
    debugPrint(data.toString());
    notifyListeners();
  }

  void addDataInDate(String date, Map<String, String> dataAdd) {
    whereday = data.indexWhere((json) => json["Date"] == date);
    debugPrint(whereday.toString());
    List<Map<String, String>> datalist = data[whereday]["data"];
    debugPrint(datalist.toString());
    datalist.add(dataAdd);
    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    notifyListeners();
  }
}
