import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp2022_front/main.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Material(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/4.jpg'),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/Imagen1.png'),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Rest(context),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget Rest(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        height: 35,
        width: 65,
        child: DotsIndicator(
          dotsCount: 3,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: const Text(
              "Mejora en los estudios, empezando el primer cambio en ti",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(67, 58, 108, 10),
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: MakeTheFirstMove(context),
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: IAlreadyHaveAnAccount())
    ],
  );
}

Widget MakeTheFirstMove(BuildContext context) {
  return Container(
    width: 250,
    height: 70,
    child: RaisedButton(
      color: Color.fromRGBO(104, 174, 174, 10),
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      },
      child: const Text("Dar el primer paso",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}

Widget IAlreadyHaveAnAccount() {
  //cambiar a boton
  return Container(
    alignment: Alignment.center,
    child: FlatButton(
        onPressed: () {},
        child: Text("YA TENGO UNA CUENTA",
            style: TextStyle(
                color: Color.fromRGBO(104, 110, 174, 10),
                fontSize: 16.0,
                fontWeight: FontWeight.bold))),
  );
}
