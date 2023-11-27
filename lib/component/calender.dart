import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../function/stater.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime pastyear = DateTime.utc(DateTime.now().year - 1);
  DateTime nextyear = DateTime.utc(DateTime.now().year + 1);
  bool isChange = false;
  DateTime dateChanged = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime focusDay = Provider.of<Stater>(context).selectDate;
    List<String> dateMarkPr = context.watch<Stater>().dateMark;
    List dateMark = dateMarkPr.map(((e) => DateTime.parse(e))).toList();
    return TableCalendar(
      firstDay: pastyear,
      lastDay: nextyear,
      focusedDay: focusDay,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      rowHeight: 30,

      // debugPrint(Provider.of<Stater>(context, listen: false)
      //     .isSelectMonthAvailable()
      //     .toString());
      onDaySelected: (selectedDay, focusedDay) {
        Provider.of<Stater>(context, listen: false)
            .changeSelectDate(selectedDay);
      },
      headerStyle: const HeaderStyle(titleCentered: true),
      selectedDayPredicate: (day) => isSameDay(day, focusDay),
      calendarFormat: CalendarFormat.month,
      enabledDayPredicate: (day) =>
          day.isBefore(DateTime.now()) || isSameDay(day, DateTime.now()),

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          for (DateTime d in dateMark) {
            if (day.day == d.day &&
                day.month == d.month &&
                day.year == d.year) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 13, 175, 224),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          }
          return null;
        },
      ),
    );
  }
}
