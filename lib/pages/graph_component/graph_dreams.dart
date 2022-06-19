import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/pages/graph_component/graph.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';
import 'dart:math' as math;
import 'chart_data.dart';

class GraphDreamsPage extends StatefulWidget {
  final String idSend;

  GraphDreamsPage(this.idSend);
  @override
  State<GraphDreamsPage> createState() => _GraphDreamsPageState();
}

class _GraphDreamsPageState extends State<GraphDreamsPage> {
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
              BackgroundImage('assets/6.jpg'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Horas de sueño",
                          style: TextStyle(
                              color: Color.fromRGBO(98, 89, 134, 10),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10,
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
                                  "Hoy has dormido ${exercisesList.length} horas",
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
                        "Tomar ${exercisesList.length} días",
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
    exercisesList = <ChartData>[
      for (int i = exercisesList.length - 1; i > 1; i--) ...[
        ChartData(
            dayOftheWeek[
                int.parse(exercisesList[i]["dayOfTheWeek"].toString())],
            convertToDouble(exercisesList[i]["duration"].toString()),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0)),
        //exercisesList[i]["duration"]
      ] /*ChartData("Tue", 23),
      ChartData("Wed", 34),
      ChartData("Th", 25),
      ChartData("Fr", 40)*/
    ];

    return exercisesList;
  }

  String string = "03 horas y 07 minutos";
  // convertir a numero tipo double hh.mm
  double convertToDouble(String string) {
    List<String> list = string.split(" ");
    double hours = double.parse(list[0]);
    double minutes = double.parse(list[3]);
    double total = hours + (minutes / 100);
    return total;
  }
}
