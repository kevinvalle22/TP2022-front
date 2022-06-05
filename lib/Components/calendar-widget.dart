// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/screen_form.dart';

class CalendarWidget extends StatefulWidget {
  final String idSend;

  CalendarWidget(this.idSend);
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // con formato yyyy-MM-dd HH:mm
  String selectedDayString =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

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
              selectedDayString =
                  DateFormat('yyyy-MM-dd HH:mm').format(focusDay);
              // push a new screen
            });
            /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenFormExercises(
                    "Ejercicio realizado",
                    "Escribir ejercicio realizado ...",
                    "REGISTRAR EJERICICIO",
                    widget.idSend,
                    selectedDayString),
              ),
            ); */
            print(selectedDayString);
          },
          selectedDayPredicate: (DateTime date) {
            // use this to go to screen_form.dart

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
                  color: Colors.purpleAccent, shape: BoxShape.circle)),
        ),
      ),
    );
  }
}
