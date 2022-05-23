// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/labels.dart';

class ScreenFormDiary extends StatelessWidget {
  ScreenFormDiary(this.h1, this.input, this.button);
  String h1;
  String input;
  String button;
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
          ],
          color: Color.fromRGBO(128, 124, 183, 10),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  h1,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            InputLabel(input),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 300,
                height: 50,
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Text(button,
                      style: TextStyle(
                          fontSize: 15.5,
                          color: Color.fromRGBO(107, 174, 174, 10),
                          fontWeight: FontWeight.bold)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenFormExercises extends StatefulWidget {
  ScreenFormExercises(this.h1, this.input, this.button);
  String h1;
  String input;
  String button;

  @override
  State<ScreenFormExercises> createState() => _ScreenFormExercisesState();
}

class _ScreenFormExercisesState extends State<ScreenFormExercises> {
  int contadorHoras = 0;
  int contadorMinutos = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int contadorHoras = 0;
    int contadorMinutos = 0;
  }

  void aumentar_horas() {
    setState(() {
      if (contadorHoras < 23) contadorHoras++;
    });
  }

  void disminuir_horas() {
    setState(() {
      if (contadorHoras > 0) contadorHoras--;
    });
  }

  void aumentar_minutos() {
    setState(() {
      if (contadorMinutos < 59) contadorMinutos++;
    });
  }

  void disminuir_minutos() {
    setState(() {
      if (contadorMinutos > 0) contadorMinutos--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
          ],
          color: Color.fromRGBO(128, 124, 183, 10),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.h1,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            InputLabel(widget.input),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Row(
                  children: [
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text("$contadorHoras horas"),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                            color: Colors.white,
                            onPressed: aumentar_horas,
                            icon: Icon(Icons.arrow_drop_up)),
                        IconButton(
                            color: Colors.white,
                            onPressed: disminuir_horas,
                            icon: Icon(Icons.arrow_drop_down))
                      ],
                    )
                  ],
                )),
                Container(
                    child: Row(
                  children: [
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text("$contadorMinutos minutos"),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                            color: Colors.white,
                            onPressed: aumentar_minutos,
                            icon: Icon(Icons.arrow_drop_up)),
                        IconButton(
                            color: Colors.white,
                            onPressed: disminuir_minutos,
                            icon: Icon(Icons.arrow_drop_down))
                      ],
                    )
                  ],
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 300,
                height: 50,
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Text(widget.button,
                      style: TextStyle(
                          fontSize: 15.5,
                          color: Color.fromRGBO(107, 174, 174, 10),
                          fontWeight: FontWeight.bold)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
