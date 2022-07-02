import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/Components/screen_form.dart';
import 'package:tp2022_front/models/Thoughts.dart';
import 'package:tp2022_front/pages/diary_components/Mod%20and%20Create%20thoughts/thoughts_create.dart';
import 'package:tp2022_front/pages/diary_components/Mod%20and%20Create%20thoughts/thoughts_mod.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

class DiaryPage extends StatefulWidget {
  final String idSend;

  DiaryPage(this.idSend);
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Deseas regresar al menú principal?"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(widget.idSend))),
                  child: Text("Si")),
            ],
          ));
  final TextEditingController message = TextEditingController();
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String selectedDayString =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<dynamic> thoughtList = [];
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    thoughtList =
        await dataBaseHelper.getThoughts(widget.idSend, name, password);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                child: Stack(
              children: <Widget>[
                Container(
                    child: BackgroundImage(
                        'assets/fondos/diario de pensamientos.png')),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TitleHeader("Pensamientos"),
                      Row(
                        children: [
                          H1Label("Mi lista de pensamientos"),
                          Container(
                              child: IconButton(
                            icon: Image.asset('assets/icons/add.png'),
                            iconSize: 20,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ThoughstCreate(widget.idSend)));
                            },
                          ))
                        ],
                      ),
                      ThoughtsChart(context)
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
      ),
    );
  }

  Widget ThoughtsChart(BuildContext context) {
    List<String> date = [];
    List<String> numberDate = [];
    List<String> month = [];
    List<String> year = [];
    List<String> fecha = [];
    for (int i = 0; i < thoughtList.length; i++) {

      fecha.add(DateFormat("MMM dd yyyy").format(
          DateTime.parse(thoughtList[i]['createdAt'].substring(0, 10))));

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
      //si es mayor a 10 quitar el 0
    }
    return SingleChildScrollView(
        child: Column(
      children: [
        if (thoughtList.isNotEmpty) ...[
          for (int i = 0; i < thoughtList.length; i++)
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
                            thoughtList[i]['message'],
                            style: TextStyle(fontSize: 13),
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
                                    dataBaseHelper.deleteAnThought(
                                        widget.idSend,
                                        name,
                                        password,
                                        int.parse(
                                            thoughtList[i]['id'].toString()));
                                    thoughtList =
                                        await dataBaseHelper.getThoughts(
                                            widget.idSend, name, password);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DiaryPage(widget.idSend)));
                                  } else if (value == "Modificar") {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ThoughtsMod(widget.idSend)));
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
                      alignment: Alignment.centerRight,
                      child: Text(
                        //Jul 02 2022
                          fecha[i].split(" ")[1]+" de "+fecha[i].split(" ")[0]+" del "+fecha[i].split(" ")[2],
                          style: TextStyle(fontSize: 12,color: Colors.grey)),
                    )
                  ],
                ),
              ),
            )
        ] else ...[
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "No hay elementos en la lista",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]
      ],
    ));
  }
}
