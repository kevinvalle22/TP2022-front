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
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter myState) {
                            return AnimatedPadding(
                              padding: MediaQuery.of(context).viewInsets,
                              duration: Duration(seconds: 1),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 2,
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
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              "Registro de horas",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24),
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
                                              title: Text(
                                                "Sueño Largo",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              checkColor: Colors.greenAccent,
                                              activeColor: Colors.green,
                                              value: suenio,
                                              onChanged: (value) {
                                                myState(() {
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
                                              title: Text(
                                                "Sueño corto durante el mismo día",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              checkColor: Colors.greenAccent,
                                              activeColor: Colors.green,
                                              value: siesta,
                                              onChanged: (value) {
                                                myState(() {
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
                                      child: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.84,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          controller: message,
                                          autofocus: true,
                                          decoration: InputDecoration.collapsed(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.auto,
                                              hintText:
                                                  "Escribir descripción ..."),
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
                                              onTap: () {
                                                myState(() {
                                                  print(suenio);
                                                  _showIni(context);
                                                  //_showA();
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
                                              onTap: () {
                                                myState(() {
                                                  print(suenio);
                                                  _showFin(context);
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
                                              //validar que todos los campos esten llenos
                                              if (message.text.isEmpty) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Error de validación"),
                                                        content: Text(
                                                            "Falta ingresar la descripción"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child:
                                                                Text("Aceptar"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else if (resultIn == null) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Error de validación"),
                                                        content: Text(
                                                            "Falta ingresar la hora inicial"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child:
                                                                Text("Aceptar"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else if (resultFin == null) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Error de validación"),
                                                        content: Text(
                                                            "Falta ingresar la hora final"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child:
                                                                Text("Aceptar"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else if (num.parse(
                                                      resultIn.toString()) >
                                                  num.parse(
                                                      resultFin.toString())) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Error de validación"),
                                                        content: Text(
                                                            "La hora inicial no puede ser mayor a la final"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child:
                                                                Text("Aceptar"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else if (num.parse(
                                                      resultIn.toString()) >
                                                  num.parse(
                                                      resultFin.toString())) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Error de validación"),
                                                        content: Text(
                                                            "La hora inicial no puede ser mayor a la final"),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child:
                                                                Text("Aceptar"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else {
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
                                                      formatter.format(a.add(
                                                          Duration(days: 1)));
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
                                                  sleepRecord.message =
                                                      message.text;
                                                  sleepRecord =
                                                      await dataBaseHelper
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
                                                                  widget
                                                                      .idSend)));
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
                                                  sleepRecord.message =
                                                      message.text;
                                                  sleepRecord =
                                                      await dataBaseHelper
                                                          .createASleepRecord(
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
                                                                  widget
                                                                      .idSend)));
                                                }
                                              }
                                            },
                                            child: Text("REGISTRAR HORAS",
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
        DreamsChart(context),
      ],
    );
  }

  Widget DreamsChart(BuildContext context) {
    List<String> duracion = [];
    for (int i = 0; i < sleepList.length; i++) {
      duracion.add(sleepList[i]['duration']);
      //aumentar 24 horas
      duracion =
          duracion.map((e) => e.startsWith('-') ? e.substring(1) : e).toList();
    }
    return SingleChildScrollView(
        child: Column(
      children: [
        if (sleepList.isNotEmpty) ...[
          for (int i = 0; i < sleepList.length; i++)
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  // ajust el tamaño de la columna
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Dormí un total de: " + duracion[i] + " horas",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: PopupMenuButton<String>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                tooltip: "Opciones",
                                onSelected: (String value) async {
                                  if (value == "Eliminar") {
                                    final name =
                                        await UserSecureStorage.getUsername() ??
                                            '';
                                    final password =
                                        await UserSecureStorage.getPassword() ??
                                            '';
                                    dataBaseHelper.deleteAnSleepRecord(
                                        widget.idSend,
                                        name,
                                        password,
                                        int.parse(
                                            sleepList[i]['id'].toString()));
                                    sleepList =
                                        await dataBaseHelper.getSleepsRecords(
                                            widget.idSend, name, password);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DreamRecordsPage(
                                                    widget.idSend)));
                                  }
                                  if (value == "Modificar") {
                                    SleepRecord sleepRecord = SleepRecord();
                                    sleepRecord =
                                        SleepRecord.fromJson(sleepList[i]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditSleepRecordPage(
                                                    widget.idSend,
                                                    sleepList[i]['id'])));
                                  }
                                },
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
                          "Dormí un total de: " + duracion[i] + " horas",
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
        ] else ...[
          Center(
            child: Text(
              "No hay elementos en la lista",
              style: TextStyle(fontSize: 20),
            ),
          )
        ]
      ],
    ));
  }
}

class EditSleepRecordPage extends StatefulWidget {
  final int sleepRecord;
  final String idSend;
  EditSleepRecordPage(this.idSend, this.sleepRecord);

  @override
  State<EditSleepRecordPage> createState() => _EditSleepRecordPageState();
}

class _EditSleepRecordPageState extends State<EditSleepRecordPage> {
  // variables para el formulario de un ejercicio los cuales son  message, startDate, endDate
  TextEditingController _messageController = TextEditingController();
  String startDate = "";
  String endDate = "";
  String horadeInicio = ""; //HH:mm
  String horadeFin = ""; //hh:mm
  //fecha

  // construir un calendario para la fecha de ejercicios y hora de inicio y fin
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dateTime2 = DateTime.now();
  TimeOfDay _timeOfDay2 = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
        startDate = _dateTime.toString().substring(0, 10);
      });
    }
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime2) {
      setState(() {
        _dateTime2 = picked;
        endDate = _dateTime2.toString().substring(0, 10);
      });
    }
  }

  // Format hh:mm
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _timeOfDay);
    if (picked != null && picked != _timeOfDay) {
      setState(() {
        _timeOfDay = picked;
        horadeInicio =
            _timeOfDay.hour.toString() + ":" + _timeOfDay.minute.toString();
      });
    }
  }

  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _timeOfDay2);
    if (picked != null && picked != _timeOfDay2) {
      setState(() {
        _timeOfDay2 = picked;
        horadeFin =
            _timeOfDay2.hour.toString() + ":" + _timeOfDay2.minute.toString();
      });
    }
  }

  // vistas de los botones de la fecha, hora, mensaje y guardar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar registro de sueño"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  // ajust el tamaño de la columna
                  children: [
                    // container para el mensaje
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          labelText: "Mensaje",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    // container para la fecha de inicio
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Fecha de inicio: " + startDate,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(
                          "Seleccionar fecha",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    // container para la hora de inicio
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Hora de inicio" + horadeInicio,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        child: Text(
                          "Seleccionar hora",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    // container para la fecha de fin
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Fecha de fin" + endDate,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          _selectDate2(context);
                        },
                        child: Text(
                          "Seleccionar fecha",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    // container para la hora de fin
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Hora de fin" + horadeFin,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          _selectTime2(context);
                        },
                        child: Text(
                          "Seleccionar hora",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    // container para el boton de guardar
                    Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          // guardar el ejercicio en la base de datos
                          DataBaseHelper helper = DataBaseHelper();
                          SleepRecord sleepRecord = SleepRecord();
                          final name =
                              await UserSecureStorage.getUsername() ?? "";
                          final password =
                              await UserSecureStorage.getPassword() ?? "";
                          sleepRecord.message = _messageController.text;
                          print(sleepRecord.message);
                          sleepRecord.startDate = startDate +
                              " " +
                              _timeOfDay.hour.toString() +
                              ":" +
                              _timeOfDay.minute.toString();
                          print(sleepRecord.startDate);
                          sleepRecord.endDate = endDate +
                              " " +
                              _timeOfDay2.hour.toString() +
                              ":" +
                              _timeOfDay2.minute.toString();
                          print(sleepRecord.endDate);
                          print("valores" +
                              widget.idSend +
                              " " +
                              name +
                              " " +
                              password);
                          print(widget.sleepRecord);
                          sleepRecord.id = widget.sleepRecord;

                          await helper.editASleepRecord(
                              widget.idSend, name, password, sleepRecord);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CalendarDreams(widget.idSend)),
                          );
                        },
                        child: Text("Guardar",
                            style: TextStyle(color: Colors.white)
                                .copyWith(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
