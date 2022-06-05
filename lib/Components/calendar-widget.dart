// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(182, 220, 220, 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TableCalendar(
          locale: 'es_ES',
          headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              headerPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
          focusedDay: selectedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 200)),
          startingDayOfWeek: StartingDayOfWeek.sunday,
          daysOfWeekVisible: true,
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            setState(() {
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
            print(focusedDay);
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.purpleAccent,
              shape: BoxShape.circle
            )
          ),
        ),
      ),
    );
  }
}
