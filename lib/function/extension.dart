import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './function.dart';
import 'package:provider/provider.dart';

String formatToyMEd(DateTime date) {
  return DateFormat.yMd().format(date);
}

bool isSelectDayAvailablefn(String date, BuildContext context) {
  return Provider.of<Stater>(context, listen: false)
      .data
      .where((element) => element["Date"] == date)
      .isNotEmpty;
}

int whereDateInData(String date, BuildContext context) {
  return Provider.of<Stater>(context, listen: false)
      .data
      .indexWhere((json) => json["Date"] == date);
}
