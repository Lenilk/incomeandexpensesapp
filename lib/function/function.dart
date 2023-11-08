// import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:incomeandexpensesapp/function/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Stater with ChangeNotifier {
  List todo = [];
  DateTime selectDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  List<Data> data = [
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
    pref.setString("Data11", json.encode(data.map((Data e) => e.toJson()).toList()));
    // pref.setString("Data10", json.encode(data));
    pref.setString("Date11Dm", json.encode({"datemark":dateMark}));
    debugPrint("updateSp");
    debugPrint(dateMark.toString());
  }
  String selectDateString() {
    return formatToyMd(selectDate);
  }

  bool isSelectDayAvailable(BuildContext context) {
    return isSelectDayAvailablefn(formatToyMd(selectDate), context);
  }

  void initSetData(List<Data> dataS,List<String> datemark){
    data=[...dataS];
    dateMark=[...datemark];
    debugPrint("Provider");
    debugPrint(data.toString());
    debugPrint(dateMark.toString());
    notifyListeners();
  }

  void addDateAndData(String date, Note dataAdd) {
    data.add(Data(date, [dataAdd]));
    String dateDm=(DateFormat.yMd().parse(date)).toString();
    if (!dateMark.contains(dateDm)){
         dateMark.add(dateDm);
    }
 
    debugPrint(data.toString());
    debugPrint(dateMark.toString());
    updateDataInSP();
    notifyListeners();
  }

  void addDataInDate(String date, Note dataAdd) {
    whereday = data.indexWhere((json) => json.Date == date);
    debugPrint(whereday.toString());
    // List<Note> dataL=data[whereday].data;
    // ignore: unnecessary_cast
    // List<Note> datalist = dataL.map((Note e) => Note(e.info,e.amount,e.note,e.type)).toList();
    
    data[whereday].data.add(dataAdd);
    debugPrint(data.toString());
    notifyListeners();
    updateDataInSP();
  }

  void deleteDataInDate(String date, Note dataDelete) {
    whereday = data.indexWhere((json) => json.Date == date);
    debugPrint(whereday.toString());
    // List<Note> dataL=data[whereday].data;
    // ignore: unnecessary_cast
    // List<String> datalist = dataL.map((e) => json.encode(Note(e.info,e.amount,e.note,e.type))).toList();
    debugPrint(dataDelete.toString());
    data[whereday].data.remove(dataDelete);
    // List<Note> datasave = datalist.map((e) => Note.fromJson(json.decode(e))).toList();
    // debugPrint(datalist.toString());
    // debugPrint(datasave.toString());
    debugPrint("delete");
    // data[whereday].data=datasave;
    debugPrint(data[whereday].toString());
    if (data[whereday].data.toString()==[].toString()){
      debugPrint("Delte");
      data.removeAt(whereday);
      dateMark.removeAt(whereday);
    }
    notifyListeners();
    updateDataInSP();
  }

  void updateDataInDate(
      String date, Note dataUpdate, int index) {
    whereday = data.indexWhere((json) => json.Date == date);
    debugPrint(whereday.toString());
    // List<Note> dataL=data[whereday].data;
    // ignore: unnecessary_cast
    // List<Note> datalist = dataL.map((e) => {"info":e["info"],"amount":e["amount"],"note":e["note"],"type":e["type"]} as Map<String,dynamic>).toList();
    // debugPrint(dataL.toString());
    data[whereday].data[index]=dataUpdate;
    debugPrint(data[whereday].data.toString());
    updateDataInSP();
    notifyListeners();
  }

  void changeSelectDate(DateTime newDate) {
    selectDate = newDate;
    notifyListeners();
  }
}
