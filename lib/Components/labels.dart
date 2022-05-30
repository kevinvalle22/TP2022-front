// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TitleHeader extends StatelessWidget {
  String title;
  TitleHeader(
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title,
            style: TextStyle(
                color: Color.fromRGBO(98, 89, 134, 10),
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        Divider(
          color: Color.fromRGBO(146, 150, 187, 10),
          thickness: 1,
        ),
      ],
    );
  }
}

class H1Label extends StatelessWidget {
  String h1;
  H1Label(
    this.h1,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          h1,
          style: TextStyle(
              color: Color.fromRGBO(147, 150, 186, 10),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  InputLabel(this.text);
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        //color: Colors.white,
        decoration: BoxDecoration(
            color: Color.fromRGBO(245, 242, 250, 10),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                dragStartBehavior: DragStartBehavior.start,
                decoration: InputDecoration.collapsed(hintText: text),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagsLabelObjective extends StatelessWidget {
  var duration = ["Corto Plazo", "Mediano Plazo", "Largo Plazo"];
  List<Color> colors = [
    Color.fromRGBO(186, 152, 209, 10),
    Color.fromRGBO(106, 168, 231, 10),
    Color.fromRGBO(156, 212, 176, 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (int i = 0; i < duration.length; i++)
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors[i],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  duration[i],
                  style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class TagsCategories extends StatelessWidget {
  var duration = ["Estilo de vida", "Salud", "Alimentación"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (int i = 0; i < duration.length; i++)
              Container(
                width: 110,
                height: 35,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  duration[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ButtomLabel extends StatelessWidget {
  ButtomLabel(this.text);
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 300,
        height: 50,
        child: RaisedButton(
          color: Color.fromRGBO(107, 174, 174, 10),
          onPressed: () {},
          child: Text(text,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}

class ContainerLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(246, 239, 227, 10),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ]),
      child: Text(
          "Hoy me sentí muy feliz porque pude dar una buena exposición parcial para mi trabajo de la universidad."),
    );
  }
}

class ContainerLabelExercises extends StatelessWidget {
  List<String> hours = [
    "0 horas y 30 minutos",
    "0 horas y 5 minutos",
    "0 horas y 15 minutos",
    "0 horas y 10 minutos",
    "0 horas y 5 minutos"
  ];
  List<String> exercises = ["Salir a correr", "Cardio", "Yoga", "Yoga", "Yoga"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 5; i++)
          Container(
            width: 400,
            height: 60,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(246, 239, 227, 10),
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      hours[i].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(exercises[i].toString()))
              ],
            ),
          )
      ],
    );
  }
}

class ContainerLabelDreams extends StatelessWidget {
  List<String> hours = [
    "0 horas y 30 minutos",
    "01 horas y 05 minutos",
    "07 horas y 15 minutos",
  ];
  List<String> exercises = ["Siesta de la tarde", "Siesta de la tarde", "Sueño Cotidiano"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < hours.length; i++)
          Container(
            width: 400,
            height: 60,
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(246, 239, 227, 10),
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      hours[i].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(exercises[i].toString()))
              ],
            ),
          )
      ],
    );
  }
}


class ListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(.1), blurRadius: 3)
          ],
          color: Color.fromRGBO(254, 227, 211, 10),
          borderRadius: BorderRadius.circular(9.0)),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(
            Icons.favorite,
            color: Color.fromRGBO(219, 167, 138, 10),
          ),
          Flexible(
            child: Text(
              "A",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
