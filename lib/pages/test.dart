import 'package:flutter/material.dart';

Widget ScreenImage() {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/originals/1b/da/2f/1bda2fa61500b9e918cec3061e5507ca.jpg'),
            fit: BoxFit.cover)),
  );
}

var reminders = [
  "Objetivos",
  "Recordatorio",
  "Diario de pensamientos"
];

Widget ScreenReminders(item,double w, double h) {
  return Container(
    padding: const EdgeInsets.only(top: 20.0),
    child: Container(
      //45 y 70
      width: w,
      height: h,
      child: Center(child: Text(reminders[item],style: TextStyle(fontSize: 11),textAlign: TextAlign.center,)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromRGBO(232, 227, 238, 10)
      ),
    ),
  );
}

var listChatText = [
  "¡Hola! Soy tu asistente virtual que te ayudará a realizar los test de ansiedad y tristeza, ¿Con cuál te gustaría empezar?",
  "Test de ansiedad",
  "¡Genial! Empezaré con las preguntas de poco a poco ¿vale?"
];



Widget Screen(item,double w) {
  return Container(
    padding: const EdgeInsets.only(top: 25.0),
    child: Container(
      //45 y 70
      width: w,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Text(listChatText[item]),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)),
          color: Color.fromRGBO(232, 227, 238, 10)
      ),
    )
    ,
  );
}

var activities = [
  "Registro de sueños",
  "Ejercicios de respiración",
  "Aprender algo nuevo",
  "Registro de ejercicios físicos",
  "Gráficas"
];

Widget ScreenActivities(item,double w, double h) {
  return Container(
    padding: const EdgeInsets.only(top: 20.0),
    child: Container(
      //45 y 70
      width: w,
      height: h,
      child: Center(child: Text(activities[item],style: TextStyle(fontSize: 11),textAlign: TextAlign.center,)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromRGBO(232, 227, 238, 10)
      ),
    ),
  );
}