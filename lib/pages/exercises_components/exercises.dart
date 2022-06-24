import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';

class ExercisesPage extends StatefulWidget {
  final String idSend;

  ExercisesPage(this.idSend);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  List<String> exercices = [
    "Ejercicio 1",
    'Ejercicio 2',
    'Ejercicio 3',
    'Ejercicio 4',
    'Ejercicio 5',
    'Ejercicio 6',
  ];
  String text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex.";
  bool _boxes = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: <Widget>[
            Container(
              child: BackgroundImage('assets/2.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TitleHeader("Ejercicios de respiración "),
                  if (_boxes == true) ...[
                    H1Label("Ejercicios"),
                    Wrap(
                      children: <Widget>[
                        for (int i = 0; i < 6; i++)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _boxes = false;
                                });
                              },
                              child: Container(
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
                                  width: 150,
                                  height: 160,
                                  child: Center(
                                      child: Text(exercices[i].toString()))),
                            ),
                          )
                      ],
                    )
                  ] else
                    Column(
                      children: [
                        H1Label("Respiración consciente"),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
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
                                padding: EdgeInsets.all(10.0),
                                child: Text(text),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            child: Text("Duración estimada: 5 min aprox")
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _boxes = true;
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/bot.png'),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
    );
  }
}
