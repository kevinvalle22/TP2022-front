import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';

//void main() => runApp(ObjectivePage());

class ObjectivePage extends StatefulWidget {
  final String idSend;

  ObjectivePage(this.idSend);

  @override
  State<ObjectivePage> createState() => _ObjectivePage();
}

class _ObjectivePage extends State<ObjectivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Stack(
            children: <Widget>[
              Container(
                child: BackgroundImage('assets/7.jpg'),
              ),
              Column(
                children: <Widget>[
                  TitleHeader("Objetivos"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  H1Label("Mis objetivos"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(147, 150, 186, 10),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed('/newObjective');
                                          },
                                          child: Icon(
                                            Icons.add_to_photos,
                                            color: Colors.white,
                                          )))
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Salud física",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 2,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Alimentación",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 1,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Estudios",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Estilo de vida",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 1,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Salud y bienestar",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 2,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Salud y bienestar",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 2,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Estudios",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Contenedor(
                                  name: "Estilo de vida",
                                  description:
                                      "Hacer ejercicios físicos constantemente.",
                                  indexDuration: 1,
                                ),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              )
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
    );
  }
}

class Contenedor extends StatelessWidget {
  Contenedor(
      {required this.name, required this.description, this.indexDuration = 0});

  String name;
  String description;
  int indexDuration;
  var duration = ["Corto Plazo", "Mediano Plazo", "Largo Plazo"];
  List<Color> colors = [
    Color.fromRGBO(186, 152, 209, 10),
    Color.fromRGBO(106, 168, 231, 10),
    Color.fromRGBO(156, 212, 176, 10)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(254, 238, 211, 10),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors[indexDuration],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      duration[indexDuration],
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            Container(alignment: Alignment.centerLeft, child: Text(description))
          ],
        ),
      ),
    );
  }
}
