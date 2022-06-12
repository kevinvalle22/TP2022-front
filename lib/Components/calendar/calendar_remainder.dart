import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/utils/endpoints.dart';

import '../labels.dart';

class CalendarRemainer extends StatefulWidget {
  final String idSend;
  CalendarRemainer(this.idSend);
  @override
  State<CalendarRemainer> createState() => _CalendarRemainerState();
}

class _CalendarRemainerState extends State<CalendarRemainer> {
  int contadorHoras = 0;
  int contadorMinutos = 0;
  int contadorHoras2 = 0;
  int contadorMinutos2 = 0;
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  final TextEditingController _dateController = TextEditingController();

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // con formato yyyy-MM-dd HH:mm
  String selectedDayString =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

  late bool _switchValue = true;
  late bool _switchValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
        ),
        Container(
          child: Row(
            children: [
              H1Label("Lista de Recordatorios"),
              Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(182, 220, 220, 10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _bottomSheet(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }

  _bottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            //duration: const Duration(seconds: 1),
            //curve: Curves.easeInOut,
            child: Container(
              height: MediaQuery.of(context).size.height / 2 + 50,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
                ],
                color: Color.fromRGBO(128, 124, 183, 10),
              ),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                        child: Text(
                          "Recordatorio",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 70,
                    //color: Colors.white,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 242, 250, 10),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ]),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration.collapsed(
                                hintText: "Escribir un Recordatorio"),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("$contadorHoras horas"),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              IconButton(
                                  color: Colors.white,
                                  onPressed: aumentar_horas,
                                  icon: Icon(Icons.arrow_drop_up)),
                              IconButton(
                                  color: Colors.white,
                                  onPressed: disminuir_horas,
                                  icon: Icon(Icons.arrow_drop_down))
                            ],
                          )
                        ],
                      )),
                      Container(
                          child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("$contadorMinutos minutos"),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              IconButton(
                                  color: Colors.white,
                                  onPressed: aumentar_minutos,
                                  icon: Icon(Icons.arrow_drop_up)),
                              IconButton(
                                  color: Colors.white,
                                  onPressed: disminuir_minutos,
                                  icon: Icon(Icons.arrow_drop_down))
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                  SizedBox(height:10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 50,
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () async {
                            /*if (selectedDayString == "exercises") {
                        Exercise exercise = Exercise();
                        var userName = await UserSecureStorage.getUsername();
                        var password = await UserSecureStorage.getPassword();
                        exercise.duration =
                            "$contadorHoras horas y $contadorMinutos minutos";
                        exercise.exerciseDate = _dateController.text;
                        exercise = await dataBaseHelper.createExercise(
                          widget.idSend,
                          userName.toString(),
                          password.toString(),
                          exercise,
                        );
                      } else if (widget.selectedDayString == "dream") {
                        SleepRecord sleepRecord = SleepRecord();
                        var userName = await UserSecureStorage.getUsername();
                        var password = await UserSecureStorage.getPassword();
                        // obtener la fecha actual
                        var now = new DateTime.now();
                        var formatter = new DateFormat('yyyy-MM-dd HH:mm');
                        print("fecha inicial: ${formatter}");
                        sleepRecord.startDate = formatter.format(now);

                        var horas;
                        var minutos;
                        if (contadorHoras < 10) {
                          horas = "0$contadorHoras";
                        } else {
                          horas = "$contadorHoras";
                        }
                        if (contadorMinutos < 10) {
                          minutos = "0$contadorMinutos";
                        } else {
                          minutos = "$contadorMinutos";
                        }
                        print(sleepRecord.endDate);
                        sleepRecord.endDate =
                            "${_dateController.text} $horas:$minutos";
                        print(sleepRecord.endDate);
                        sleepRecord = await dataBaseHelper.createASleepRecord(
                          widget.idSend,
                          userName.toString(),
                          password.toString(),
                          sleepRecord,
                        );
                      }

                      Navigator.pop(context);
                  */
                          },
                          child: Text("Registrar Recordatorio",
                              style: TextStyle(
                                  fontSize: 15.5,
                                  color: Color.fromRGBO(107, 174, 174, 10),
                                  fontWeight: FontWeight.bold)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void aumentar_horas() {
    setState(() {
      if (contadorHoras < 23) contadorHoras++;
    });
  }

  void disminuir_horas() {
    setState(() {
      if (contadorHoras > 0) contadorHoras--;
    });
  }

  void aumentar_minutos() {
    setState(() {
      if (contadorMinutos < 59) contadorMinutos++;
    });
  }

  void disminuir_minutos() {
    setState(() {
      if (contadorMinutos > 0) contadorMinutos--;
    });
  }

  Widget RemindersChart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
          ],
          color: Color.fromRGBO(226, 238, 239, 10),
          borderRadius: BorderRadius.circular(9.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tomar Agua.",
                  style: TextStyle(fontSize: 18),
                ),
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: myBoxDecoration(),
                          child: Text("L",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      // ignore: prefer_const_constructors
                      Text(
                        "M",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: myBoxDecoration(),
                          child: Text("M",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      Text(
                        "J",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: myBoxDecoration(),
                          child: Text("V",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      Text(
                        "S",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: myBoxDecoration(),
                          child: Text("D",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(8.0),
                  decoration: timeBoxDecoration(),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "05:15 AM",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Color.fromRGBO(107, 174, 174, 10), shape: BoxShape.circle);
  }

  BoxDecoration timeBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(107, 174, 174, 10),
      borderRadius: BorderRadius.circular(25),
    );
  }
}
