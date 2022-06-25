import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/models/Exercise.dart';
import 'package:tp2022_front/pages/exercises_components/record_exercises.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

import '../labels.dart';
import '../screen_form.dart';

class CalendarExercises extends StatefulWidget {
  final String idSend;
  CalendarExercises(this.idSend);
  @override
  State<CalendarExercises> createState() => _CalendarExercisesState();
}

class _CalendarExercisesState extends State<CalendarExercises> {
  TimeOfDay? resultIn = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay? resultFin = TimeOfDay(hour: 00, minute: 00);
  final TextEditingController message = TextEditingController();
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // con formato yyyy-MM-dd HH:mm
  String selectedDayString =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  Future<void> _showIni() async {
    resultIn = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    print(resultFin!.hour - resultIn!.hour);
  }

  Future<void> _showFin() async {
    resultFin = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    print(resultFin!.hour);
  }

  List<dynamic> exercisesList = [];
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    exercisesList =
        await dataBaseHelper.getExercises(widget.idSend, name, password);

    print("sleepList: " + exercisesList.toString());
    print("first: " + exercisesList[0].toString());
    print("startDate first: " + exercisesList[0]["startDate"].toString());
    print("size: " + exercisesList.length.toString());

    //convert string to int
    //lista vacia  mensaje de error

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

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
                  //get lima colombia time
                  selectedDayString =
                      DateFormat('yyyy-MM-dd').format(selectedDay);
                });
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
        Row(
          children: [
            H1Label("Historial de ejercicios"),
            Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(182, 220, 220, 10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return AnimatedPadding(
                              padding: MediaQuery.of(context).viewInsets,
                              duration: Duration(seconds: 1),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.1),
                                        blurRadius: 3)
                                  ],
                                  color: Color.fromRGBO(128, 124, 183, 10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "Ejercicio realizado",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      height: 50,
                                      //color: Colors.white,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(245, 242, 250, 10),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                            )
                                          ]),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              autofocus: true,
                                              controller: message,
                                              decoration: InputDecoration.collapsed(
                                                  hintText:
                                                      "Escribir ejercicio realizado ..."),
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                            child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              child: Text(
                                                "Hora inicial",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Text(":",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                      )
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .watch_later_outlined),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(resultIn!.hour
                                                              .toString()
                                                              .padLeft(2, '0') +
                                                          ":" +
                                                          resultIn!.minute
                                                              .toString()
                                                              .padLeft(2, '0')),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              //ontap setstate to get time
                                              onTap: () => {
                                                setState(() {
                                                  _showIni();
                                                })
                                              },
                                            ),
                                          ],
                                        )),
                                        Container(
                                            child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              child: Text(
                                                "Hora final",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Text(":",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                      )
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons
                                                          .watch_later_outlined),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(resultFin!.hour
                                                              .toString()
                                                              .padLeft(2, '0') +
                                                          ":" +
                                                          resultFin!.minute
                                                              .toString()
                                                              .padLeft(2, '0')),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: () => _showFin(),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Container(
                                          width: 300,
                                          height: 50,
                                          child: RaisedButton(
                                            color: Colors.white,
                                            onPressed: () async {
                                              Exercise exercise = Exercise();
                                              var userName =
                                                  await UserSecureStorage
                                                      .getUsername();
                                              var password =
                                                  await UserSecureStorage
                                                      .getPassword();
                                              exercise.startDate =
                                                  selectedDayString +
                                                      " " +
                                                      resultIn!.hour
                                                          .toString()
                                                          .padLeft(2, '0') +
                                                      ":" +
                                                      resultIn!.minute
                                                          .toString()
                                                          .padLeft(2, '0');
                                              print("Fecha de inicio" +
                                                  exercise.startDate);
                                              exercise.endDate =
                                                  selectedDayString +
                                                      " " +
                                                      resultFin!
                                                          .hour
                                                          .toString()
                                                          .padLeft(2, '0') +
                                                      ":" +
                                                      resultFin!.minute
                                                          .toString()
                                                          .padLeft(2, '0');
                                              print("Fecha de inicio" +
                                                  exercise.endDate);
                                              exercise.message = message.text;
                                              exercise = await dataBaseHelper
                                                  .createExercise(
                                                widget.idSend,
                                                userName.toString(),
                                                password.toString(),
                                                exercise,
                                              );

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecordExercisesPage(
                                                              widget.idSend)));
                                            },
                                            child: Text("REGISTRAR EJERCICIO",
                                                style: TextStyle(
                                                    fontSize: 15.5,
                                                    color: Color.fromRGBO(
                                                        107, 174, 174, 10),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        ExercisesChart(context)
      ],
    );
  }

  Widget ExercisesChart(BuildContext context) {
    List<String> date = [];
    for (int i = 0; i < exercisesList.length; i++) {
      //cambiar a de ingles a español el dayOfTheWeek
      date.add(exercisesList[i]['dayOfTheWeek']);
      date = date.map((e) => e.replaceAll('MONDAY', 'Lunes')).toList();
      date = date.map((e) => e.replaceAll('TUESDAY', 'Martes')).toList();
      date = date.map((e) => e.replaceAll('WEDNESDAY', 'Miércoles')).toList();
      date = date.map((e) => e.replaceAll('THRUSDAY', 'Jueves')).toList();
      date = date.map((e) => e.replaceAll('FRIDAY', 'Viernes')).toList();
      date = date.map((e) => e.replaceAll('SATURDAY', 'Sábado')).toList();
      date = date.map((e) => e.replaceAll('SUNDAY', 'Domingo')).toList();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < exercisesList.length; i++)
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 239, 227, 10),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Duración: " +
                                (exercisesList[i]["duration"].toString()) +
                                " horas",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: PopupMenuButton<String>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                tooltip: "Opciones",
                                /*onSelected: (String value) {
                                    if (value == "Eliminar") {
                                      dataBaseHelper.deleteReminder(
                                          remindersList[i]['id']);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReminderPage(widget.idSend)));
                                    }
                                  },*/
                                //padding: EdgeInsets.zero,
                                onSelected: (String value) async {
                                  if (value == "Eliminar") {
                                    final name =
                                        await UserSecureStorage.getUsername() ??
                                            '';
                                    final password =
                                        await UserSecureStorage.getPassword() ??
                                            '';
                                    dataBaseHelper.deleteAnExercise(
                                        widget.idSend,
                                        name,
                                        password,
                                        int.parse(
                                            exercisesList[i]['id'].toString()));
                                    exercisesList =
                                        await dataBaseHelper.getExercises(
                                            widget.idSend, name, password);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecordExercisesPage(
                                                    widget.idSend)));
                                  }
                                },
                                icon: Icon(Icons.more_horiz),
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: "Modificar",
                                        child: ListTile(
                                          leading: Icon(Icons.edit),
                                          title: Text("Modificar"),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: "Eliminar",
                                        child: ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text("Eliminar"),
                                        ),
                                      )
                                    ]))
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Fecha: " + exercisesList[i]["startDate"].toString(),
                        )),
                    Container(alignment: Alignment.centerLeft, child: Text(
                        // Mayuscula la primera letra  y despues todo minusculas
                        "Día de la semana: " + date[i])),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ejercicio a realizar: " +
                              exercisesList[i]["message"].toString(),
                        )),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
