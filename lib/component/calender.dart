import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../function/function.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime pastyear = DateTime.utc(DateTime.now().year - 1);
  DateTime nextyear = DateTime.utc(DateTime.now().year + 1);
  @override
  Widget build(BuildContext context) {
    DateTime focusDay = Provider.of<Stater>(context).selectDate;
    return SizedBox(
      height: 270,
      child: TableCalendar(
        firstDay: pastyear,
        lastDay: nextyear,
        focusedDay: focusDay,
        rowHeight: 30,
        onDaySelected: (selectedDay, focusedDay) {
          Provider.of<Stater>(context, listen: false)
              .changeSelectDate(selectedDay);
        },
        headerStyle: const HeaderStyle(titleCentered: true),
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        selectedDayPredicate: (day) => isSameDay(day, focusDay),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            for (DateTime d in [DateTime(2022)]) {
              if (day.day == d.day &&
                  day.month == d.month &&
                  day.year == d.year) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 221, 8, 8),
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
      ),
    );
  }
}
