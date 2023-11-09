import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './function.dart';
import 'package:provider/provider.dart';


String formatToyMd(DateTime date) {
  return DateFormat.yMd().format(date);
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
