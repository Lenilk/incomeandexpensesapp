import 'package:intl/intl.dart';
import './function.dart';

String formatToyMEd(DateTime date) {
  return DateFormat.yMEd().format(date);
}

bool isSelectDayAvailablefn(String date) {
  return Stater().data[date] != null;
}
