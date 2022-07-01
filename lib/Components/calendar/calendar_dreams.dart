import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/models/SleepRecord.dart';
import 'package:tp2022_front/pages/dream_component/Mod%20and%20create%20dreams/dream_register_create.dart';
import 'package:tp2022_front/pages/dream_component/Mod%20and%20create%20dreams/dream_register_mod.dart';
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
        Row(
          children: [
            H1Label("Horas de Sueño"),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DreamRegisterDreamCreate(widget.idSend)));
              },
              icon: Image.asset("assets/icons/add.png"),
            )
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
                                  } else if (value == "Modificar") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DreamRegisterDreamMod(
                                                    widget.idSend)));
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
