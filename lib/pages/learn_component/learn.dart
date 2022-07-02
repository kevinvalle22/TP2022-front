import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/pages/learn_component/second_tip/second_tip.dart';

final tips = [
  '¿Qué es CBT?',
  '¿Cómo cuidar mi salud mental?',
  'Tips para una mejor organización',
  '¿Cómo manejar mi enojo?',
  '10 consejos para cuidar tu salud mental',
  '¿La salud mental puede afectar en mis estudios?',
];
final tips2 = [
  '10 consejos para cuidar tu salud mental',
  '¿Cómo manejar mi enojo?',
  'tips para empezar el amor propio',
  'La procrastinación',
  '¿Cómo establecer objetivos smart?',
  '¿las afirmaciones realmente me ayudan?',
];
List<Color> colores1 = [
  Color.fromRGBO(55, 111, 142, 1),
  Color.fromRGBO(94, 144, 99, 1),
  Color.fromRGBO(128, 88, 29, 1),
  Color.fromRGBO(55, 111, 142, 1),
  Color.fromRGBO(94, 144, 99, 1),
  Color.fromRGBO(128, 88, 29, 1),
];
List<Color> colores2 = [
  Color.fromRGBO(202, 229, 249, 1),
  Color.fromRGBO(217, 244, 198, 1),
  Color.fromRGBO(254, 220, 169, 1),
  Color.fromRGBO(202, 229, 249, 1),
  Color.fromRGBO(217, 244, 198, 1),
  Color.fromRGBO(254, 220, 169, 1),
];
List<Color> colores5 = [
  Color.fromRGBO(254, 220, 169, 1),
  Color.fromRGBO(202, 229, 249, 1),
  Color.fromRGBO(178, 255, 237, 1),
  Color.fromRGBO(179, 255, 167, 1),
  Color.fromRGBO(198, 189, 255, 1),
  Color.fromRGBO(255, 176, 176, 1),
];
int a = 0;
String text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex.";

class LearnPage extends StatefulWidget {
  final String idSend;

  LearnPage(this.idSend);
  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(colores2.length);
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
            child: Container(
                child: Stack(
              children: <Widget>[
                Container(
                  child: BackgroundImage('assets/fondos/info.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TitleHeader("Aprende algo nuevo"),
                      Column(
                        children: [
                          H1Label("Recomendaciones para ti"),
                          CarouselSlider(
                            items: [
                              for (int i = 0; i < tips.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    if (tips[0] == tips[i]) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MentalHealthPages(
                                                    widget.idSend,
                                                  )));
                                    } else if (tips[1] == tips[i]) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MentalHealthPages(
                                                    widget.idSend,
                                                  )));
                                    } else if (tips[2] == tips[i]) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MentalHealthPages(
                                                    widget.idSend,
                                                  )));
                                    } else if (tips[3] == tips[i]) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MentalHealthPages(
                                                    widget.idSend,
                                                  )));
                                    } else if (tips[4] == tips[i]) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MentalHealthPages(
                                                    widget.idSend,
                                                  )));
                                    } else if (tips[5] == tips[i]) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MentalHealthPages(
                                                    widget.idSend,
                                                  )));
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: colores2[i],
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
                                      width: 200,
                                      child: Center(
                                          child: Text(
                                        tips[i],
                                        style: TextStyle(
                                            color: colores1[i],
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ))),
                                ),
                            ],
                            options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayCurve: Curves.easeInOut,
                              scrollDirection: Axis.horizontal,
                              viewportFraction: 0.5,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          H1Label("Psicología"),
                          SizedBox(
                            height: 10,
                          ),
                          Psicologia("¿Qué es el CBT?"),
                          H1Label("Tips y consejos"),
                          Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < tips2.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: colores5[i],
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
                                      height: 120,
                                      width: MediaQuery.of(context).size.width /
                                          3.7,
                                      child: Center(
                                          child: Text(
                                        tips2[i].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                115, 112, 108, 1)),
                                      ))),
                                ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          isTheSameLearn: true,
          learnColorIcon: false,
          idSend: widget.idSend,
        ),
      ),
    );
  }

  Widget Psicologia(String texto) {
    List<Color> colores3 = [
      Color.fromRGBO(222, 199, 255, 1),
      Color.fromRGBO(184, 232, 232, 1),
      Color.fromRGBO(254, 201, 226, 1),
    ];
    List<Color> colores4 = [
      Color.fromRGBO(84, 29, 160, 1),
      Color.fromRGBO(31, 148, 148, 1),
      Color.fromRGBO(174, 76, 122, 1),
    ];
    List<String> fraseP = [
      "¿Qué es el CBT?",
      "¿Por qué es importante el test gad-7?",
      "¿Qué mide el test PHQ-9?",
    ];
    return Column(
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: colores3[i],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ]),
            child: Text(
              fraseP[i],
              style: TextStyle(
                color: colores4[i],
                fontSize: 18,
              ),
            ),
          ),
      ],
    );
  }
}
