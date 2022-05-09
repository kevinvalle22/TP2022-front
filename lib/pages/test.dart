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


Widget Screens(number, double x, double y) {
  return Padding(
    padding: const EdgeInsets.only(top: 25.0),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for(int i = 0; i < number; i++)
            Container(
              //45 y 70
              padding: EdgeInsets.symmetric(vertical: x, horizontal: y),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  color: Color.fromRGBO(232, 227, 238, 10)
              ),
            ),
        ],
      ),)
    ,
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)),
          color: Color.fromRGBO(232, 227, 238, 10)
      ),
    )
    ,
  );
}

