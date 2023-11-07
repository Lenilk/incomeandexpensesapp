// import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:incomeandexpensesapp/function/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Stater with ChangeNotifier {
  List todo = [];
  DateTime selectDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  List<Map<String, dynamic>> data = [
   //{info: ffhjj, amount: 665, note: , type: income}
  ];
  List<String> dateMark = [];
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
  void updateDataInSP()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("Data6", json.encode(data));
    pref.setString("Date6Dm", json.encode({"datemark":dateMark}));
    debugPrint("updateSp");
    debugPrint(dateMark.toString());
  }
  String selectDateString() {
    return formatToyMd(selectDate);
  }

  bool isSelectDayAvailable(BuildContext context) {
    return isSelectDayAvailablefn(formatToyMd(selectDate), context);
  }

  void initSetData(List<Map<String,dynamic>> dataS,List<String> datemark){
    data=[...dataS];
    dateMark=[...datemark];
    debugPrint("Provider");
    debugPrint(data.toString());
    debugPrint(dateMark.toString());
    notifyListeners();
  }

  void addDateAndData(String date, Map<String, String> dataAdd) {
    data.add({
      "Date": date,
      "data": [dataAdd]
    });
    String dateDm=(DateFormat.yMd().parse(date)).toString();
    if (!dateMark.contains(dateDm)){
         dateMark.add(dateDm);
    }
 
    debugPrint(data.toString());
    debugPrint(dateMark.toString());
    updateDataInSP();
    notifyListeners();
  }

  void addDataInDate(String date, Map<String, dynamic> dataAdd) {
    whereday = data.indexWhere((json) => json["Date"] == date);
    debugPrint(whereday.toString());
    List<dynamic> dataL=data[whereday]["data"];
    // ignore: unnecessary_cast
    List<Map<String,dynamic>> datalist = dataL.map((e) => {"info":e["info"],"amount":e["amount"],"note":e["note"],"type":e["type"]} as Map<String,dynamic>).toList();
    debugPrint(datalist.toString());
    datalist.add(dataAdd);
    data[whereday]["data"]=datalist;
    notifyListeners();
    updateDataInSP();
  }

  void deleteDataInDate(String date, Map<String, dynamic> dataDelete) {
    whereday = data.indexWhere((json) => json["Date"] == date);
    debugPrint(whereday.toString());
    List<dynamic> dataL=data[whereday]["data"];
    // ignore: unnecessary_cast
    List<String> datalist = dataL.map((e) => json.encode({"info":e["info"],"amount":e["amount"],"note":e["note"],"type":e["type"]})).toList();
    debugPrint(dataDelete.toString());
    datalist.remove(json.encode((dataDelete)));
    List<Map<String,dynamic>> datasave = datalist.map((e) => json.decode(e) as Map<String,dynamic>).toList();
    debugPrint(datalist.toString());
    debugPrint(datasave.toString());
    debugPrint("delete");
    data[whereday]["data"]=datasave;
    debugPrint(data[whereday].toString());
    if (data[whereday]["data"].toString()==[].toString()){
      debugPrint("Delte");
      data.removeAt(whereday);
      dateMark.removeAt(whereday);
    }
    notifyListeners();
    updateDataInSP();
  }

  void updateDataInDate(
      String date, Map<String, String> dateUpdate, int index) {
    whereday = data.indexWhere((json) => json["Date"] == date);
    debugPrint(whereday.toString());
    List<dynamic> dataL=data[whereday]["data"];
    // ignore: unnecessary_cast
    List<Map<String,dynamic>> datalist = dataL.map((e) => {"info":e["info"],"amount":e["amount"],"note":e["note"],"type":e["type"]} as Map<String,dynamic>).toList();
    debugPrint(datalist.toString());
    datalist[index] = dateUpdate;
    data[whereday]["data"]=datalist;
    updateDataInSP();
    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    notifyListeners();
  }
}
