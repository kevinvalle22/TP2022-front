// ignore_for_file: deprecated_member_use, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';

void main() => runApp(PositveReinforcementPage());

class PositveReinforcementPage extends StatefulWidget {
  @override
  State<PositveReinforcementPage> createState() =>
      _PositveReinforcementPageState();
}

class _PositveReinforcementPageState extends State<PositveReinforcementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(child: Cuerpo(context)),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

Widget Cuerpo(BuildContext context) {
  return Column(
    children: <Widget>[
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/7.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 50,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 50,
            child: Components(),
          ),
        ],
      )
    ],
  );
}

class Components extends StatefulWidget {
  const Components({Key? key}) : super(key: key);

  @override
  State<Components> createState() => _ComponentsState();
}

class _ComponentsState extends State<Components> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Header(),
        ),
        Container(
          child: Body(),
        )
      ],
    );
  }
}

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Name(),
    );
  }

  Widget Name() {
    return IntrinsicWidth(
      child: Column(
        children: const [
          Text("Afirmaciones",
              style: TextStyle(
                  color: Color.fromRGBO(67, 58, 108, 10),
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            width: 410,
            child: Divider(
              color: Color.fromRGBO(146, 150, 187, 10),
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String afirm = '';
  int cont = 0;
  int cont2 = 0;
  Color buttonColor = Colors.black;
  List<String> lista = <String>[];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Row(
            children: [
              const Text("Afirmación diaria",
                  style: TextStyle(
                      color: Color.fromRGBO(146, 150, 187, 10),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              IconButton(
                  icon: Image.asset('assets/bell_slash.png'), onPressed: () {}),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Affirmation(context)),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: const Text("Escribir afirmaciones personalizadas",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: CustomAffirmattons(context),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: const Text("Mis Favoritas",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: SizedBox(
            child: Affirmations(context, afirm),
            height: 200,
          ),
        ),
      ],
    );
  }

  Widget Affirmation(BuildContext context) {
    List<String> entries = <String>[
      '"Yo estoy feliz con quien soy aquí y ahora."',
      '"Celebré cada meta que logre con gratitud y alegría."',
      '"Soy feliz y libre porque soy yo"',
      '"Estoy aprendiendo a confiar en el viaje"',
      '"Soy capaz. Tengo potencial para triunfar"',
      '"Creo en un mundo libre de estrés para mi"'
    ];
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width - 45,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
            ],
            color: Color.fromRGBO(243, 212, 229, 10),
            borderRadius: BorderRadius.circular(9.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topRight,
                // ignore: prefer_const_constructors
                child: IconButton(
                    icon: Image.asset(
                      'assets/reload.png',
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        afirm = '';
                        if (cont2 != 5) {
                          buttonColor = Colors.black;
                          cont2++;
                        } else {
                          cont2 = 0;
                        }
                      });
                    }),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width - 100,
                alignment: Alignment.center,
                // ignore: prefer_const_constructors
                child: Text(entries[cont2],
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed('/assertion_settings');
                    },
                    child: Container(
                      // ignore: prefer_const_constructors
                      child: const Icon(Icons.more_horiz),
                    ),
                  ),
                  Container(
                    // ignore: prefer_const_constructors
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      color: buttonColor,
                      onPressed: () {
                        setState(() {
                          afirm = entries[cont2];
                          if (cont == 1) {
                            buttonColor = Colors.black;
                          } else {
                            buttonColor = Colors.red;
                          }
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomAffirmattons(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width - 45,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
            ],
            color: Color.fromRGBO(193, 222, 228, 10),
            borderRadius: BorderRadius.circular(9.0)),
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: const Color.fromRGBO(146, 150, 187, 10),
                    hintText: "Escribe tu afirmación ...",
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(146, 150, 187, 10)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromRGBO(232, 227, 238, 10)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: RaisedButton(
                  color: const Color.fromRGBO(104, 174, 174, 6),
                  onPressed: () {},
                  child: const Text(
                    "GUARDAR EN FAVORITO",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Affirmations(BuildContext context, String quote) {
    List names = [
      '"Soy feliz y libre porque soy yo"',
      "Estoy aprendiendo a confiar en el viaje",
      '"Soy capaz. Tengo potencial para triunfar"',
      "Creo en el mundo libre de estrés para mi"
    ];

    if (quote != '') {
      if (lista.contains(quote)) {
        cont = 0;
        lista.remove(quote);
      } else {
        cont = 1;
        lista.add(quote);
      }
    }
    return ListView.builder(
        padding: const EdgeInsets.all(9),
        itemCount: lista.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //height: 40,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(.1), blurRadius: 3)
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
                    lista[index],
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        });
  }
}