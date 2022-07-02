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
    List<String> fechaInicial = [];
    List<String> minutosInicial = [];
    List<String> horasInicial = [];

    List<String> fechaFinal = [];
    List<String> minutosFinal = [];
    List<String> horasFinal = [];

    for (int i = 0; i < sleepList.length; i++) {
      horasInicial.add(sleepList[i]["startDate"].toString().substring(11, 13));
      minutosInicial
          .add(sleepList[i]["startDate"].toString().substring(14, 16));
      fechaInicial.add(sleepList[i]["startDate"].toString().substring(0, 10));

      horasFinal.add(sleepList[i]["endDate"].toString().substring(11, 13));
      minutosFinal
          .add(sleepList[i]["endDate"].toString().substring(14, 16));
      fechaFinal.add(sleepList[i]["endDate"].toString().substring(0, 10));
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
                            "Dormí un total de: " +
                                sleepList[i]['duration'].toString() +
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
                          "Me fui a dormir a las " +
                              horasInicial[i] +
                              ":" +
                              minutosInicial[i] +
                              " hrs el " +
                              fechaInicial[i],
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Me desperté a las " +
                              horasFinal[i] +
                              ":" +
                              minutosFinal[i] +
                              " hrs el " +
                              fechaFinal[i],
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
