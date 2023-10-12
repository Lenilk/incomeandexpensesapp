// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:incomeandexpensesapp/function/extension.dart';

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
    String day = DateFormat("EEE").format(selectDate);
    String tday = "วัน";
    switch (day) {
      case "Sun":
        tday += "อาทิตย์";
      case "Mon":
        tday += "จันทร์";
      case "Tue":
        tday += "อังคาร";
      case "Wed":
        tday += "พุธ";
      case "Thu":
        tday += "พฤหัสบดี";
      case "Fri":
        tday += "ศุกร์";
      case "Sat":
        tday += "เสาร์";
    }
    String month = thmonth(selectDate);
    return DateFormat("$tday วันที่ d $month").format(selectDate);
  }

  String selectDateString() {
    return formatToyMd(selectDate);
  }

  bool isSelectDayAvailable(BuildContext context) {
    return isSelectDayAvailablefn(formatToyMd(selectDate), context);
  }

  void addDateAndData(String date, Map<String, String> dataAdd) {
    data.add({
      "Date": date,
      "data": [dataAdd]
    });
    dateMark.add(DateFormat.yMd().parse(date));
    setDatainSP(data);
    debugPrint(data.toString());
    notifyListeners();
  }

  void addDataInDate(String date, Map<String, String> dataAdd) {
    whereday = data.indexWhere((json) => json["Date"] == date);
    debugPrint(whereday.toString());
    List<Map<String, String>> datalist = data[whereday]["data"];
    debugPrint(datalist.toString());
    datalist.add(dataAdd);
    setDatainSP(data);
    notifyListeners();
  }

  void deleteDataInDate(String date, Map<String, String> dataDelete) {
    whereday = data.indexWhere((json) => json["Date"] == date);
    debugPrint(whereday.toString());
    List<Map<String, String>> datalist = data[whereday]["data"];
    debugPrint(datalist.toString());
    datalist.remove(dataDelete);
    setDatainSP(data);
    notifyListeners();
  }

  void updateDataInDate(
      String date, Map<String, String> dateUpdate, int index) {
    whereday = data.indexWhere((json) => json["Date"] == date);
    debugPrint(whereday.toString());
    List<Map<String, String>> datalist = data[whereday]["data"];
    debugPrint(datalist.toString());
    datalist[index] = dateUpdate;
    setDatainSP(data);
    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    notifyListeners();
  }
}
