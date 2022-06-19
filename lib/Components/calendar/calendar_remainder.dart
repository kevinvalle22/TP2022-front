import 'dart:io';
import 'dart:math';
//import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/models/Reminder.dart';
import 'package:tp2022_front/pages/reminder_component/reminder.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
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
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  final TextEditingController message = TextEditingController();

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // con formato yyyy-MM-dd HH:mm
  String selectedDayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool _switchValue = true;
  late bool _switchValue2 = false;

  List<dynamic> remindersList = [];
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';

    remindersList =
        await dataBaseHelper.getReminders(widget.idSend, name, password);
    List<String> list = [];
    /* for (var i = 0; i < remindersList.length; i++) {
      list.add(remindersList[i]["reminderDate"]);
    } */
    print("remindersList: " + list.toString());

    print(selectedDayString);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void aumentar_horas() {
    if (contadorHoras < 23) contadorHoras++;
  }

  void disminuir_horas() {
    if (contadorHoras > 0) contadorHoras--;
  }

  void aumentar_minutos() {
    if (contadorMinutos < 59) contadorMinutos++;
    print(contadorMinutos);
  }

  void disminuir_minutos() {
    if (contadorMinutos > 0) contadorMinutos--;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              H1Label("Recordatorios"),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(182, 220, 220, 10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () {
                    //_bottomSheet(context);
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Stack(
                              children: [
                                Container(
                                    child: BackgroundImage('assets/7.jpg')),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 35,
                                    ),
                                    TitleHeader("Recordatorio"),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        margin: EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(182, 220, 220, 10),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: TableCalendar(
                                          rowHeight: 40,
                                          locale: 'es_ES',
                                          headerStyle: HeaderStyle(
                                              titleCentered: true,
                                              formatButtonVisible: false,
                                              titleTextStyle: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                              headerPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 10)),
                                          focusedDay: selectedDay,
                                          firstDay: DateTime.now(),
                                          lastDay: DateTime.now()
                                              .add(Duration(days: 200)),
                                          startingDayOfWeek:
                                              StartingDayOfWeek.sunday,
                                          daysOfWeekVisible: true,
                                          onDaySelected: (DateTime selectDay,
                                              DateTime focusDay) {
                                            setState(() {
                                              selectedDay = selectDay;
                                              focusedDay = focusDay;
                                              selectedDayString =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(focusDay);
                                              // push a new screen
                                            });
                                            print(selectedDayString);
                                          },
                                          selectedDayPredicate:
                                              (DateTime date) {
                                            return isSameDay(selectedDay, date);
                                          },
                                          calendarStyle: CalendarStyle(
                                              isTodayHighlighted: true,
                                              selectedDecoration: BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                              selectedTextStyle: TextStyle(
                                                  color: Colors.white),
                                              todayDecoration: BoxDecoration(
                                                  color: Colors.purpleAccent,
                                                  shape: BoxShape.circle)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.4,
                                        padding: EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                                blurRadius: 3)
                                          ],
                                          color:
                                              Color.fromRGBO(128, 124, 183, 10),
                                        ),
                                        child: Column(
                                          //mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                    "Recordatorio",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              height: 50,
                                              //color: Colors.white,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      245, 242, 250, 10),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                    )
                                                  ]),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextField(
                                                      controller: message,
                                                      decoration: InputDecoration
                                                          .collapsed(
                                                              hintText:
                                                                  "Escribir un Recordatorio"),
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                    child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 2,
                                                              blurRadius: 5,
                                                            )
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons
                                                                .watch_later_outlined),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                                '$contadorHoras horas'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        IconButton(
                                                            color: Colors.white,
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    aumentar_horas();
                                                                  })
                                                                },
                                                            icon: Icon(Icons
                                                                .arrow_drop_up)),
                                                        IconButton(
                                                            color: Colors.white,
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    disminuir_horas();
                                                                  })
                                                                },
                                                            icon: Icon(Icons
                                                                .arrow_drop_down))
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
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 2,
                                                              blurRadius: 5,
                                                            )
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons
                                                                .watch_later_outlined),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                                "$contadorMinutos minutos"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        IconButton(
                                                            color: Colors.white,
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    aumentar_minutos();
                                                                  })
                                                                },
                                                            icon: Icon(Icons
                                                                .arrow_drop_up)),
                                                        IconButton(
                                                            color: Colors.white,
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    disminuir_minutos();
                                                                  })
                                                                },
                                                            icon: Icon(Icons
                                                                .arrow_drop_down))
                                                      ],
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Container(
                                                  width: 300,
                                                  height: 50,
                                                  child: RaisedButton(
                                                    color: Colors.white,
                                                    onPressed: () async {
                                                      Reminder reminder =
                                                          Reminder();
                                                      var userName =
                                                          await UserSecureStorage
                                                              .getUsername();
                                                      var password =
                                                          await UserSecureStorage
                                                              .getPassword();
                                                      var horas;
                                                      var minutos;
                                                      if (contadorHoras < 10) {
                                                        horas =
                                                            "0$contadorHoras";
                                                      } else {
                                                        horas =
                                                            "$contadorHoras";
                                                      }
                                                      if (contadorMinutos <
                                                          10) {
                                                        minutos =
                                                            "0$contadorMinutos";
                                                      } else {
                                                        minutos =
                                                            "$contadorMinutos";
                                                      }
                                                      var formato =
                                                          "$horas:$minutos";
                                                      var fecha =
                                                          new DateFormat(
                                                              "yyyy-MM-dd");

                                                      reminder
                                                          .reminderDate = fecha
                                                              .format(
                                                                  selectedDay)
                                                              .toString() +
                                                          " $horas:$minutos";

                                                      print(reminder
                                                          .reminderDate);
                                                      reminder.message =
                                                          message.text;
                                                      print(reminder.message);
                                                      reminder =
                                                          await dataBaseHelper
                                                              .createAReminder(
                                                                  widget.idSend,
                                                                  userName
                                                                      .toString(),
                                                                  password
                                                                      .toString(),
                                                                  reminder);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ReminderPage(
                                                                      widget
                                                                          .idSend)));
                                                    },
                                                    child: Text(
                                                        "Registrar Recordatorio",
                                                        style: TextStyle(
                                                            fontSize: 15.5,
                                                            color:
                                                                Color.fromRGBO(
                                                                    107,
                                                                    174,
                                                                    174,
                                                                    10),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                        });
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        RemindersChart(context),
      ],
    );
  }

  Widget RemindersChart(BuildContext context) {
    List<String> hours = [];
    List<String> minutes = [];
    List<String> date = [];
    for (int i = 0; i < remindersList.length; i++) {
      hours.add(remindersList[i]['reminderDate'].substring(11, 13));
      minutes.add(remindersList[i]['reminderDate'].substring(14, 16));
      // formato de fecha en español
      date.add(DateFormat("EEEE MMM dd, yyyy").format(
          DateTime.parse(remindersList[i]['reminderDate'].substring(0, 10))));
      // formato de fecha en ingles de dias
      date = date.map((e) => e.replaceAll("Monday", "Lunes")).toList();
      date = date.map((e) => e.replaceAll("Tuesday", "Martes")).toList();
      date = date.map((e) => e.replaceAll("Wednesday", "Miercoles")).toList();
      date = date.map((e) => e.replaceAll("Thursday", "Jueves")).toList();
      date = date.map((e) => e.replaceAll("Friday", "Viernes")).toList();
      date = date.map((e) => e.replaceAll("Saturday", "Sabado")).toList();
      date = date.map((e) => e.replaceAll("Sunday", "Domingo")).toList();

      //reemplazar los meses abreviados a los meses completos en español con split
      //enero
      //date = date.map((e) => e.replaceAll("Jun", "June")).toList();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < remindersList.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.1), blurRadius: 3)
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
                          Flexible(
                            child: Text(
                              remindersList[i]['message'],
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
                                  padding: EdgeInsets.zero,
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: Text(
                              // split the date to get the day, month and year

                              date[i].split(" ")[0] +
                                  " " +
                                  //number of the day
                                  date[i].split(" ")[2] +
                                  " de " +
                                  date[i].split(" ")[1] +
                                  " del " +
                                  date[i].split(" ")[3],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(8.0),
                            decoration: timeBoxDecoration(),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  hours[i] + ":" + minutes[i] + " horas",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
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
              ),
            ),
        ],
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
