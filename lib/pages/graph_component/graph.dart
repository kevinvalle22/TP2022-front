// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/chart/subscriber_chart.dart';
import 'package:tp2022_front/Components/chart/subscriber_series.dart';

class GraphPage extends StatefulWidget {
  final String idSend;

  GraphPage(this.idSend);
  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  /*constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),*/
                  //padding: EdgeInsets.all(10),
                  //margin: EdgeInsets.symmetric(vertical: 10),
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
                          backgroundColor: Color.fromRGBO(165, 109, 139, 10),
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
                            Text(
                              "Gráfica de sueño",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
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
                                      color: Color.fromRGBO(98, 89, 134, 10),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Emociones",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
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
                  height: 10,
                ),
                Container(
                  width: 400,
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
                )
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigation(
          isTheSameGraph: true, graphColorIcon: false, idSend: widget.idSend),
    );
  }
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
