import 'dart:ffi';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

import 'chart_data.dart';
import 'graph.dart';

class GraphExercisesPage extends StatefulWidget {
  final String idSend;

  GraphExercisesPage(this.idSend);
  @override
  State<GraphExercisesPage> createState() => _GraphExercisesPageState();
}

class _GraphExercisesPageState extends State<GraphExercisesPage> {
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
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: "Horas de ejercicio registradas",
      format: 'El día point.x se realizó point.y horas de ejercicio',
    );
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
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Text("Grafico ejercicios físicos",
                            style: TextStyle(
                                color: Color.fromRGBO(98, 89, 134, 10),
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    CalendarWidget(widget.idSend),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Graficos de registro de ejercicios",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
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
                        tooltipBehavior: _tooltipBehavior,
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
                              enableTooltip: true,
                              width: 1,
                              spacing: 0.2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "(Tomar en consideración a ${exercisesList.length} días)",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
    var data;
    data = <ChartData>[
      for (int i = 0; i < exercisesList.length; i++) ...[
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
    return data;
  }

  String string = "03";
  double convertToDouble(String string) {
    // convertir a numero tipo double un String ejemplo "2"
    double number = double.parse(string.split(" ")[0]);
    // convertir a numero tipo double un String ejemplo "2"

    return number;
  }
}
