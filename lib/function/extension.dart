import 'package:intl/intl.dart';
import './function.dart';

String formatToyMEd(DateTime date) {
  return DateFormat.yMd().format(date);
}

bool isSelectDayAvailablefn(String date) {
  return Stater().data.where((element) => element["Date"] == date).isNotEmpty;
}

int whereDateInData(String date) {
  return Stater().data.indexWhere((json) => json["Date"] == date);
}
