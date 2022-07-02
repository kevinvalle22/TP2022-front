import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/models/SleepRecord.dart';
import 'package:tp2022_front/pages/dream_component/dream_register.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

class DreamRegisterDreamMod extends StatefulWidget {
  final String idSend;
  final String idDream;
  DreamRegisterDreamMod(this.idSend, this.idDream);

  @override
  State<DreamRegisterDreamMod> createState() => _DreamRegisterDreamModState();
}

class _DreamRegisterDreamModState extends State<DreamRegisterDreamMod> {
  String? fechaIn = "00:00";
  String? fechaFin = "00:00";
  bool suenio = false;
  bool siesta = false;
  final TextEditingController message = TextEditingController();
  TimeOfDay? resultIn = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay? resultFin = TimeOfDay(hour: 00, minute: 00);

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // con formato yyyy-MM-dd HH:mm
  String selectedDayString =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  String currentedDayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  Future _showIni(BuildContext context) async {
    resultIn = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (resultIn != null) {
      setState(() {
        fechaIn = resultIn!.format(context);
      });
    }
    if (resultIn == null) {
      fechaIn = fechaIn;
    }
    print(resultIn!.hour);
    print(fechaIn);
  }

  Future<void> _showFin(BuildContext context) async {
    resultFin = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (resultIn != null) {
      setState(() {
        fechaFin = resultFin!.format(context);
      });
    }
    if (resultFin == null) {
      fechaFin = fechaFin;
    }
    print(resultFin!.hour);
    print(fechaFin);
  }

  List<dynamic> sleepList = [];
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    sleepList =
        await dataBaseHelper.getSleepsRecords(widget.idSend, name, password);

    print("sleepList: " + sleepList.toString());
    print("first: " + sleepList[0].toString());
    print("startDate first: " + sleepList[0]["startDate"].toString());
    print("size: " + sleepList.length.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                    child: BackgroundImage(
                        'assets/fondos/ejercicios fisicos.png')),
                SafeArea(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          TitleHeader("Horas de Sueño"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(252, 252, 252, 10),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TableCalendar(
                                locale: 'es_ES',
                                headerStyle: HeaderStyle(
                                    titleCentered: true,
                                    formatButtonVisible: false,
                                    titleTextStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    headerPadding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10)),
                                rowHeight:
                                    MediaQuery.of(context).size.height * 0.060,
                                focusedDay: selectedDay,
                                firstDay: DateTime.now(),
                                lastDay:
                                    DateTime.now().add(Duration(days: 200)),
                                startingDayOfWeek: StartingDayOfWeek.sunday,
                                daysOfWeekVisible: true,
                                onDaySelected:
                                    (DateTime selectDay, DateTime focusDay) {
                                  setState(() {
                                    selectedDay = selectDay;
                                    focusedDay = focusDay;
                                    //get lima colombia time
                                    selectedDayString = DateFormat('yyyy-MM-dd')
                                        .format(selectedDay);
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
                                    selectedTextStyle:
                                        TextStyle(color: Colors.white),
                                    todayDecoration: BoxDecoration(
                                        color: Colors.purpleAccent,
                                        shape: BoxShape.circle)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 3)
                              ],
                              color: Color.fromRGBO(128, 124, 183, 10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          "Modificar registro de horas de sueño",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
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
                                        child: CheckboxListTile(
                                          //poner texto en checkbox
                                          //checkboxShape: CircleBorder(),
                                          dense: true,
                                          title: Text(
                                            "Sueño profundo",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          checkColor: Colors.transparent,
                                          activeColor:
                                              Color.fromRGBO(55, 51, 108, 1),
                                          value: suenio,
                                          onChanged: (value) {
                                            setState(() {
                                              suenio = value!;
                                              print(suenio);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
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
                                        child: CheckboxListTile(
                                          //poner texto en checkbox
                                          dense: true,
                                          //checkboxShape: CircleBorder(),
                                          title: Text(
                                            "Sueño corto durante el mismo día",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          checkColor: Colors.transparent,
                                          activeColor:
                                              Color.fromRGBO(55, 51, 108, 1),
                                          value: siesta,
                                          onChanged: (value) {
                                            setState(() {
                                              siesta = value!;
                                              print(siesta);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 50,
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
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.84,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: message,
                                      decoration: InputDecoration.collapsed(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.auto,
                                          hintText: "Escribir descripción ..."),
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                    ),
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
                                                    BorderRadius.circular(15),
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
                                                  Text(fechaIn!),
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              print(suenio);
                                              _showIni(context);
                                            });
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
                                                    BorderRadius.circular(15),
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
                                                  Text(fechaFin!),
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              print(suenio);
                                              _showFin(context);
                                            });
                                            (() {
                                              //_showA();
                                            });
                                          },
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
                                          SleepRecord sleepRecord =
                                              SleepRecord();
                                          var userName = await UserSecureStorage
                                              .getUsername();
                                          var password = await UserSecureStorage
                                              .getPassword();
                                          // obtener la fecha actual
                                          var now = DateTime.now()
                                              .add(Duration(days: 1));
                                          var formatter =
                                              DateFormat('yyyy-MM-dd');
                                          print("fecha inicial: ${formatter}");
                                          if (suenio == true) {
                                            sleepRecord.startDate =
                                                selectedDayString +
                                                    " " +
                                                    resultIn!.hour
                                                        .toString()
                                                        .padLeft(2, '0') +
                                                    ":" +
                                                    resultIn!.minute
                                                        .toString()
                                                        .padLeft(2, '0');
                                            print(sleepRecord.startDate);
                                            //add 1 day to the selected day
                                            var a = DateTime.parse(
                                                selectedDayString);
                                            //aumentarle 1 día al día seleccionado
                                            currentedDayString =
                                                formatter.format(
                                                    a.add(Duration(days: 1)));
                                            //obtener la fecha final
                                            sleepRecord.endDate =
                                                currentedDayString +
                                                    " " +
                                                    resultFin!.hour
                                                        .toString()
                                                        .padLeft(2, '0') +
                                                    ":" +
                                                    resultFin!.minute
                                                        .toString()
                                                        .padLeft(2, '0');
                                            print(sleepRecord.endDate);
                                            sleepRecord.message = message.text;
                                            sleepRecord = await dataBaseHelper
                                                .createASleepRecord(
                                              widget.idSend,
                                              userName.toString(),
                                              password.toString(),
                                              sleepRecord,
                                            );
                                            print("sueño");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DreamRecordsPage(
                                                            widget.idSend)));
                                          } else if (siesta == true) {
                                            sleepRecord.startDate =
                                                selectedDayString +
                                                    " " +
                                                    resultIn!.hour
                                                        .toString()
                                                        .padLeft(2, '0') +
                                                    ":" +
                                                    resultIn!.minute
                                                        .toString()
                                                        .padLeft(2, '0');
                                            print(sleepRecord.startDate);
                                            //add 1 day to the selected day
                                            sleepRecord.endDate =
                                                selectedDayString +
                                                    " " +
                                                    resultFin!.hour
                                                        .toString()
                                                        .padLeft(2, '0') +
                                                    ":" +
                                                    resultFin!.minute
                                                        .toString()
                                                        .padLeft(2, '0');
                                            print(sleepRecord.endDate);
                                            sleepRecord.message = message.text;
                                            sleepRecord.id =
                                                int.parse(widget.idDream);
                                            sleepRecord = await dataBaseHelper
                                                .editASleepRecord(
                                              widget.idSend,
                                              userName.toString(),
                                              password.toString(),
                                              sleepRecord,
                                            );
                                            print("siesta");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DreamRecordsPage(
                                                            widget.idSend)));
                                          }
                                        },
                                        child: Text("REGISTRAR HORAS",
                                            style: TextStyle(
                                                fontSize: 15.5,
                                                color: Color.fromRGBO(
                                                    107, 174, 174, 10),
                                                fontWeight: FontWeight.bold)),
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
                        ],
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
}
