import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'stater.dart';
import 'package:provider/provider.dart';

String formatToyMd(DateTime date) {
  return DateFormat.yMd().format(date);
}

DateTime parseDateFromJson(String dateString) {
  return DateFormat.yMd().parse(dateString);
}

bool isSelectDayAvailablefn(String date, BuildContext context) {
  return Provider.of<Stater>(context, listen: false)
      .data
      .where((element) => element.Date == date)
      .isNotEmpty;
}

int whereDateInData(String date, BuildContext context) {
  return Provider.of<Stater>(context, listen: false)
      .data
      .indexWhere((json) => json.Date == date);
}

String thday(DateTime date) {
  String day = DateFormat('EEE').format(date);
  String tday = 'วัน';
  switch (day) {
    case 'Sun':
      tday += 'อาทิตย์';
    case 'Mon':
      tday += 'จันทร์';
    case 'Tue':
      tday += 'อังคาร';
    case 'Wed':
      tday += 'พุธ';
    case 'Thu':
      tday += 'พฤหัสบดี';
    case 'Fri':
      tday += 'ศุกร์';
    case 'Sat':
      tday += 'เสาร์';
  }
  return tday;
}

String thmonth(DateTime date) {
  String month = DateFormat('MMM').format(date);
  String tmonth = 'เดือน';
  switch (month) {
    case 'Jan':
      tmonth += 'มกราคม';
    case 'Feb':
      tmonth += 'กุมภาพันธ์';
    case 'Mar':
      tmonth += 'มีนาคม';
    case 'Apr':
      tmonth += 'เมษายน';
    case 'May':
      tmonth += 'พฤษภาคม';
    case 'Jun':
      tmonth += 'มิถุนายน';
    case 'Jul':
      tmonth += 'กรกฎาคม';
    case 'Aug':
      tmonth += 'สิงหาคม';
    case 'Sep':
      tmonth += 'กันยายน';
    case 'Oct':
      tmonth += 'ตุลาคม';
    case 'Nov':
      tmonth += 'พฤศจิกายน';
    case 'Dec':
      tmonth += 'ธันวาคม';
  }
  return tmonth;
}

String monthAndYearTH(DateTime date) {
  String month = thmonth(date);
  int year = date.year;
  return 'เดือน$month ปี $year';
}

String dateThDay(String date) {
  int day = parseDateFromJson(date).day;
  return 'วันที่ $day';
}
