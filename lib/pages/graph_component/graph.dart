// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/chart/subscriber_chart.dart';
import 'package:tp2022_front/Components/chart/subscriber_series.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tp2022_front/pages/graph_component/graph_moods.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

import 'chart_data.dart';
import 'graph_dreams.dart';
import 'graph_exercises.dart';

class GraphPage extends StatefulWidget {
  final String idSend;

  GraphPage(this.idSend);
  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
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
            title: Text("¿Quieres salir de esta sección?"),
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
  late TooltipBehavior _tooltipBehavior;
  List<dynamic> exercisesList = [];
  DataBaseHelper httpHelper = new DataBaseHelper();
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    exercisesList =
        await httpHelper.getExercises(widget.idSend, name, password);

    print("sleepList: " + exercisesList.toString());
    print("first: " + exercisesList[0].toString());
    print("startDate first: " + exercisesList[0]["startDate"].toString());
    print("size: " + exercisesList.length.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    _tooltipBehavior = TooltipBehavior(enable: true);
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
              BackgroundImage('assets/6.jpg'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Mis Estadísticas",
                          style: TextStyle(
                              color: Color.fromRGBO(98, 89, 134, 10),
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(232, 227, 238, 10),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircularPercentIndicator(
                              animation: true,
                              radius: 100,
                              backgroundColor:
                                  Color.fromRGBO(165, 109, 139, 10),
                              progressColor: Color.fromRGBO(236, 181, 210, 10),
                              startAngle: 80.0,
                              percent: .6,
                              lineWidth: 20,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  "Hoy has dormido 7 horas",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                Text(
                                  "Te recomendamos dormir un",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  "poco más la próxima vez",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Gráfica de sueño",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(147, 150, 186, 10),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GraphDreamsPage(
                                                              widget.idSend)));
                                            },
                                            child: Icon(
                                              Icons.open_in_full_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            )))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    width: 170,
                                    height: 200,
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
                                    child: Text(
                                      "Horas de sueño",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(98, 89, 134, 10),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Emociones",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                147, 150, 186, 10),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GraphMoodsPage(
                                                                widget
                                                                    .idSend)));
                                              },
                                              child: Icon(
                                                Icons.open_in_full_outlined,
                                                color: Colors.white,
                                                size: 18,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 170,
                                    height: 200,
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
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: PieChart(
                                        PieChartData(
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            sectionsSpace: 0,
                                            centerSpaceRadius: 0,
                                            sections: sectionsChart),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tiempo de ejercicios",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(147, 150, 186, 10),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GraphExercisesPage(
                                                  widget.idSend)));
                                },
                                child: Icon(
                                  Icons.open_in_full_outlined,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 420,
                      height: 250,
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
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        //tooltipBehavior: _tooltipBehavior,
                        series: <ChartSeries>[
                          ColumnSeries<ChartData, String>(
                              dataSource: getColumnas(),
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) =>
                                  data.y!.toDouble(),
                              pointColorMapper: (ChartData data, _) =>
                                  data.pointColorMapper,
                              dataLabelMapper: (ChartData data, _) =>
                                  data.y!.toStringAsFixed(1).toString() +
                                  (" ") +
                                  ("h"),
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  labelAlignment:
                                      ChartDataLabelAlignment.middle,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              //enableTooltip: true,
                              width: 1,
                              spacing: 0.2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ],
                      ),
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
      radius: 72,
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
      radius: 72,
    ),
    PieChartSectionData(
      value: 15,
      showTitle: false,
      badgeWidget: Image.asset('assets/sentimientos/alegria.png',
          fit: BoxFit.cover, width: 25, height: 25),
      color: Color.fromRGBO(155, 151, 189, 10),
      radius: 72,
    ),
  ];

  dynamic getColumnas() {
    var lists;
    lists = <ChartData>[
      for (int i = 0; i < exercisesList.length - 1; i++) ...[
        ChartData(
            exercisesList[i]["dayOfTheWeek"].toString(),
            convertToDouble(exercisesList[i]["duration"].toString()),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0)),
        //exercisesList[i]["duration"]
      ] /*ChartData("Tue", 23),
      ChartData("Wed", 34),
      ChartData("Th", 25),
      ChartData("Fr", 40)*/
    ];

    return lists;
  }

  String string = "03 horas y 07 minutos";
  // convertir a numero tipo double hh.mm
  double convertToDouble(String string) {
    // convertir a numero tipo double un String ejemplo "2"
    double number = double.parse(string.split(" ")[0]);
    // convertir a numero tipo double un String ejemplo "2"

    return number;
  }
}
