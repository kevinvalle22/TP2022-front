import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/pages/graph_component/graph.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';
import 'dart:math' as math;
import 'chart_data.dart';

class GraphMoodsPage extends StatefulWidget {
  final String idSend;

  GraphMoodsPage(this.idSend);
  @override
  State<GraphMoodsPage> createState() => _GraphMoodsPageState();
}

class _GraphMoodsPageState extends State<GraphMoodsPage> {
  List<String> dayOftheWeek = [
    "Domingo",
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado"
  ];
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Quieres regresar a la anterior Sección?"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GraphPage(widget.idSend))),
                  child: Text("Si")),
            ],
          ));
  List<dynamic> moodsList = [];
  DataBaseHelper httpHelper = new DataBaseHelper();
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    moodsList = await httpHelper.getExercises(widget.idSend, name, password);

    print("sleepList: " + moodsList.toString());
    print("first: " + moodsList[0].toString());
    print("startDate first: " + moodsList[0]["startDate"].toString());
    print("size: " + moodsList.length.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
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
        body: SingleChildScrollView(
          child: SafeArea(
              child: Stack(
            children: <Widget>[
              BackgroundImage('assets/fondos/x cada grafica.png'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text("Mis emociones",
                          style: TextStyle(
                              color: Color.fromRGBO(98, 89, 134, 10),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 15),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mis emociones de la semana",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.35,
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
                        child: Column(
                          children: [
                            Container(
                              height: 280,
                              child: PieChart(
                                PieChartData(
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 10,
                                    sections: sectionsChart),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
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
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/sentimientos/alegria.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${moodsList.length} veces",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/sentimientos/miedo.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${moodsList.length} veces",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/sentimientos/tristeza.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${moodsList.length} veces",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.085,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/sentimientos/enojo.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${moodsList.length} veces",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.085,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/sentimientos/asco.png'),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${moodsList.length} veces",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hoy",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Container(
                      child: Contenedor(
                          hora: "08:30 AM",
                          description:
                              "Sé que ha sido duro, pero todavía estamos de pie",
                          idSend: widget.idSend,
                          enable: true),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
        bottomNavigationBar: BottomNavigation(
            isTheSameGraph: true, graphColorIcon: false, idSend: widget.idSend),
      ),
    );
  }

  List<PieChartSectionData> sectionsChart = [
    PieChartSectionData(
      value: 25,
      showTitle: false,
      badgeWidget: Image.asset(
        'assets/sentimientos/tristeza.png',
        fit: BoxFit.cover,
        width: 40,
        height: 40,
      ),
      color: Color.fromRGBO(236, 181, 210, 10),
      radius: 85,
    ),
    PieChartSectionData(
      value: 60,
      showTitle: false,
      badgeWidget: Image.asset(
        'assets/sentimientos/miedo.png',
        fit: BoxFit.cover,
        width: 40,
        height: 40,
      ),
      color: Color.fromRGBO(168, 207, 207, 10),
      radius: 85,
    ),
    PieChartSectionData(
      value: 15,
      showTitle: false,
      badgeWidget: Image.asset('assets/sentimientos/alegria.png',
          fit: BoxFit.cover, width: 25, height: 25),
      color: Color.fromRGBO(155, 151, 189, 10),
      radius: 85,
    ),
  ];
}

class Contenedor extends StatefulWidget {
  final String idSend;
  Contenedor(
      {required this.hora,
      required this.description,
      required this.idSend,
      required this.enable});

  String hora;
  String description;
  bool enable = true;
  @override
  State<Contenedor> createState() => _ContenedorState();
}

class _ContenedorState extends State<Contenedor> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    widget.hora,
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.105,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sentimientos/asco.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Flexible(child: Text(widget.description)),
              ],
            ),
            Container(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: PopupMenuButton<String>(
                      enabled: widget.enable,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tooltip: "Opciones",
                      onSelected: (String value) {
                        if (value == "Modificar") {
                          /*dataBaseHelper.deleteReminder(
                                            remindersList[i]['id']);*/
                          /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ObjectiveMod(widget.idSend)));*/
                        }
                      },
                      //padding: EdgeInsets.zero,
                      icon: Icon(Icons.more_horiz),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: "Modificar",
                              child: ListTile(
                                leading: Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(139, 168, 194, 10),
                                ),
                                title: Text("Modificar",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(139, 168, 194, 10))),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: "Eliminar",
                              child: ListTile(
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                title: Text("Eliminar",
                                    style: TextStyle(color: Colors.redAccent)),
                              ),
                            )
                          ]),
                ))
          ],
        ),
      ),
    );
  }
}
