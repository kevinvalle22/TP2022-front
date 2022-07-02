import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/models/Exercise.dart';
import 'package:tp2022_front/pages/exercises_components/Mod%20and%20Create%20Exercises/record_exercises_create.dart';
import 'package:tp2022_front/pages/exercises_components/record_exercises.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

import '../../pages/exercises_components/Mod and Create Exercises/record_exercises_mod.dart';
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
        Row(
          children: [
            H1Label("Historial de ejercicios"),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecordExercisesCreate(
                              widget.idSend,
                            )));
              },
              icon: Image.asset('assets/icons/add.png'),
            )
          ],
        ),
        ExercisesChart(context)
      ],
    );
  }

  Widget ExercisesChart(BuildContext context) {
    List<String> date = [];
    List<String> fecha = [];
    List<String> minutos = [];
    for (int i = 0; i < exercisesList.length; i++) {
      //cambiar a de ingles a español el dayOfTheWeek
      date.add(exercisesList[i]['dayOfTheWeek']);
      date = date.map((e) => e.replaceAll('MONDAY', 'Lunes')).toList();
      date = date.map((e) => e.replaceAll('TUESDAY', 'Martes')).toList();
      date = date.map((e) => e.replaceAll('WEDNESDAY', 'Miércoles')).toList();
      date = date.map((e) => e.replaceAll('THURSDAY', 'Jueves')).toList();
      date = date.map((e) => e.replaceAll('FRIDAY', 'Viernes')).toList();
      date = date.map((e) => e.replaceAll('SATURDAY', 'Sábado')).toList();
      date = date.map((e) => e.replaceAll('SUNDAY', 'Domingo')).toList();
      //obtener los minutos
      fecha.add(DateFormat("EEEE MMM dd yyyy").format(
          DateTime.parse(exercisesList[i]['startDate'].substring(0, 10))));
      fecha = fecha.map((e) => e.replaceAll("Jan", "enero")).toList();
      fecha = fecha.map((e) => e.replaceAll("Feb", "febrero")).toList();
      fecha = fecha.map((e) => e.replaceAll("Mar", "marzo")).toList();
      fecha = fecha.map((e) => e.replaceAll("Apr", "abril")).toList();
      fecha = fecha.map((e) => e.replaceAll("May", "mayo")).toList();
      fecha = fecha.map((e) => e.replaceAll("Jun", "junio")).toList();
      fecha = fecha.map((e) => e.replaceAll("Jul", "julio")).toList();
      fecha = fecha.map((e) => e.replaceAll("Aug", "agosto")).toList();
      fecha = fecha.map((e) => e.replaceAll("Sep", "septiembre")).toList();
      fecha = fecha.map((e) => e.replaceAll("Oct", "octubre")).toList();
      fecha = fecha.map((e) => e.replaceAll("Nov", "noviembre")).toList();
      fecha = fecha.map((e) => e.replaceAll("Dec", "diciembre")).toList();

      fecha = fecha.map((e) => e.replaceAll('MONDAY', 'Lunes')).toList();
      fecha = fecha.map((e) => e.replaceAll('TUESDAY', 'Martes')).toList();
      fecha = fecha.map((e) => e.replaceAll('WEDNESDAY', 'Miércoles')).toList();
      fecha = fecha.map((e) => e.replaceAll('THURSDAY', 'Jueves')).toList();
      fecha = fecha.map((e) => e.replaceAll('FRIDAY', 'Viernes')).toList();
      fecha = fecha.map((e) => e.replaceAll('SATURDAY', 'Sábado')).toList();
      fecha = fecha.map((e) => e.replaceAll('SUNDAY', 'Domingo')).toList();
    }
    Color colorcito = Color.fromRGBO(200, 224, 220, 1);
    return SingleChildScrollView(
      child: Column(
        children: [
          if (exercisesList.isNotEmpty) ...[
            for (int i = 0; i < exercisesList.length; i++) ...[
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
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
                              (exercisesList[i]["duration"].toString() +
                                  " horas"),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: PopupMenuButton<String>(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  tooltip: "Opciones",
                                  onSelected: (String value) async {
                                    print("true");
                                    if (value == "Eliminar") {
                                      final name = await UserSecureStorage
                                              .getUsername() ??
                                          '';
                                      final password = await UserSecureStorage
                                              .getPassword() ??
                                          '';
                                      dataBaseHelper.deleteAnExercise(
                                          widget.idSend,
                                          name,
                                          password,
                                          int.parse(exercisesList[i]['id']
                                              .toString()));
                                      exercisesList =
                                          await dataBaseHelper.getExercises(
                                              widget.idSend, name, password);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecordExercisesPage(
                                                      widget.idSend)));
                                    } else if (value == "Modificar") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecordExercisesMod(
                                                    widget.idSend,
                                                  )));
                                    }
                                  },
                                  icon: Icon(Icons.more_horiz),
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: "Modificar",
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.edit,
                                              color: Color.fromRGBO(
                                                  139, 168, 194, 10),
                                            ),
                                            title: Text(
                                              "Modificar",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    139, 168, 194, 10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: "Eliminar",
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            title: Text(
                                              "Eliminar",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        )
                                      ]))
                        ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            exercisesList[i]["message"].toString() + ".",
                            style: TextStyle(fontSize: 16),
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date[i].split(" ")[0] +
                                " " +
                                //number of the day
                                fecha[i].split(" ")[2] +
                                " de " +
                                fecha[i].split(" ")[1] +
                                " del " +
                                fecha[i].split(" ")[3],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ]
          ] else ...[
            Center(
              child: Text(
                "No hay elementos en la lista",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ],
      ),
    );
  }
}
