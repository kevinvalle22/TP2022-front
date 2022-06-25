import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/models/SleepRecord.dart';
import 'package:tp2022_front/pages/dream_component/dream_register.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

class CalendarDreams extends StatefulWidget {
  final String idSend;
  CalendarDreams(this.idSend);
  @override
  State<CalendarDreams> createState() => _CalendarDreamsState();
}

class _CalendarDreamsState extends State<CalendarDreams> {
  //para sacar 6:15PM ejem
  String? fechaIn = "";
  String? fechaFin = "";
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
      fechaIn = resultIn!.format(context);
    }
    print(resultIn!.hour);
    print(fechaIn);
  }

  void _showA() {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        }).then((value) {
      setState(() {
        resultIn = value;
      });
    });
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
    if (resultIn != null) {
      fechaFin = resultFin!.format(context);
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
              //currentDay: focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 200)),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                  //currentedDay=cdDay;
                  selectedDayString =
                      DateFormat('yyyy-MM-dd').format(selectedDay);
                  currentedDayString =
                      DateFormat('yyyy-MM-dd').format(focusedDay);
                });
                print(currentedDayString);
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
            H1Label("Horas de Sueño"),
            Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(182, 220, 220, 10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        enableDrag: true,
                        context: context,
                        builder: (BuildContext context) {
                          return AnimatedPadding(
                            padding: MediaQuery.of(context).viewInsets,
                            duration: Duration(seconds: 1),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2.9,
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
                                //mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "Registro de horas",
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
                                            controller: message,
                                            autofocus: true,
                                            decoration: InputDecoration.collapsed(
                                                hintText:
                                                    "Escribir descripción ..."),
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
                                            onTap: () => {
                                              setState(() {
                                                _showIni(context);
                                                //_showA();
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
                                            SleepRecord sleepRecord =
                                                SleepRecord();
                                            var userName =
                                                await UserSecureStorage
                                                    .getUsername();
                                            var password =
                                                await UserSecureStorage
                                                    .getPassword();
                                            // obtener la fecha actual
                                            var now = DateTime.now()
                                                .add(Duration(days: 1));
                                            var formatter =
                                                DateFormat('yyyy-MM-dd');
                                            print(
                                                "fecha inicial: ${formatter}");
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DreamRecordsPage(
                                                            widget.idSend)));
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
                          );
                        });
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        DreamsChart(context),
      ],
    );
  }

  Widget DreamsChart(BuildContext context) {
    List<String> duracion = [];
    for (int i = 0; i < sleepList.length; i++) {
      duracion.add(sleepList[i]['duration'].substring(1, 3));
      //aumentar 24 horas
      duracion = duracion.map((e) => e.startsWith('-') ? e.substring(1) : e).toList();
    }
    return SingleChildScrollView(
        child: Column(
      children: [
        for (int i = 0; i < sleepList.length; i++)
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height / 6,
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            margin: EdgeInsets.symmetric(vertical: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                // ajust el tamaño de la columna
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Dormí un total de: " +
                              duracion[i] +
                              " horas",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        "Me fui a dormir a las: " +
                            sleepList[i]["startDate"].toString(),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Me desperté a las: " +
                            sleepList[i]["endDate"].toString(),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dormí un total de: " +
                            duracion[i] +
                            " horas",
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        sleepList[i]["message"].toString() + " .",
                      )),
                  // negrita
                ],
              ),
            ),
          )
      ],
    ));
  }
}
