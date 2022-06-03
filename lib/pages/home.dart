import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/pages/help_component/help.dart';
import 'package:tp2022_front/pages/test.dart';

import '../ControllerEndpoints/endpoints.dart';

class HomePage extends StatefulWidget {
  // get id from sign in page
  final String id;

  const HomePage({Key? key, required this.id}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(child: Cuerpo(context)),
      bottomNavigationBar: BottomNavigation(
        isTheSameHome: true,
        homeColorIcon: false,
      ),
    );
  }
}

Widget Cuerpo(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/5.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 0,
            width: 450,
            height: MediaQuery.of(context).size.height+27,
            child: Components(),
          ),
        ]),
      ],
    ),
  );
}

Widget Components() {
  return Container(
    child: Column(
      children: [
        Container(
          child: Header(),
        ),
        Container(
          child: Body(),
        )
      ],
    ),
  );
}

Widget Header() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(padding: EdgeInsets.all(15.0), child: Name()),
      Container(
        child: PhoneIcon(),
      )
    ],
  );
}

Widget Name() {
  return const Text("Hola estudiante",
      style: TextStyle(
          color: Color.fromRGBO(67, 58, 108, 10),
          fontSize: 35.0,
          fontWeight: FontWeight.bold));
}

Widget PhoneIcon() {
  return Builder(builder: (context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HelpPage()));
      },
      child: const Icon(
        Icons.phone_callback_rounded,
        color: Colors.red,
        size: 25.0,
      ),
      shape: const CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.white,
    );
  });
}

Widget Body() {
  return Builder(builder: (context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: const Text("¿Cómo te Sientes hoy?",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 325,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sentimientos/alegria.png'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sentimientos/miedo.png'),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sentimientos/tristeza.png'),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sentimientos/enojo.png'),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/sentimientos/asco.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 300,
          height: 50,
          child: RaisedButton(
            color: Color.fromRGBO(107, 174, 174, 10),
            onPressed: () {
              Navigator.of(context).pushNamed('/chatbot');
            },
            child: const Text("¿TE GUSTARIA TOMAR UN TEST?",
                style: TextStyle(
                    fontSize: 15.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Affirmation(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Reminder(context),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Activities(context),
        ),
      ],
    );
  });
}

Widget Affirmation() {
  return Builder(builder: (context) {
    return Column(
      children: <Widget>[
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
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 350,
          height: 100,
          child: RaisedButton(
            color: const Color.fromRGBO(243, 212, 229, 10),
            onPressed: () {
              Navigator.of(context).pushNamed('/positive');
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  // ignore: prefer_const_constructors
                  child: const Icon(Icons.more_horiz),
                ),
                Container(
                  child: const Text(
                      '"Yo estoy feliz con quien soy aquí y ahora."',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  // ignore: prefer_const_constructors
                  child: const Icon(
                    Icons.favorite,
                    color: Color.fromRGBO(200, 110, 137, 10),
                  ),
                ),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
        )
      ],
    );
  });
}

Widget Reminder(BuildContext context) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: const Text("Objetivos, recordatorios y diario",
            style: TextStyle(
                color: Color.fromRGBO(146, 150, 187, 10),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/objective');
                  },
                  child: Container(
                    height: 100,
                    width: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/ilustraciones/objetivos.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "OBJETIVOS",
                  style: TextStyle(
                      color: Color.fromRGBO(115, 112, 108, 10),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 8),
                )
              ],
            ),
            ///////////////////////
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/reminder');
                  },
                  child: Container(
                    height: 100,
                    width: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/ilustraciones/Recordatorios.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "RECORDATORIO",
                  style: TextStyle(
                      color: Color.fromRGBO(115, 112, 108, 10),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 8),
                )
              ],
            ),
            ///////////////////////
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/diary');
                  },
                  child: Container(
                    height: 100,
                    width: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/ilustraciones/pensamientos.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "DIARIO DE PENSAMIENTOS",
                  style: TextStyle(
                      color: Color.fromRGBO(115, 112, 108, 10),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 8),
                )
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget Activities(BuildContext context) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: const Text("Sueño, respiración y actividades",
            style: TextStyle(
                color: Color.fromRGBO(146, 150, 187, 10),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //////////////////////////////////////////////////////////
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/record_dream');
                    },
                    child: Container(
                        height: 220,
                        width: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/ilustraciones/sueño.png'),
                            ),
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "REGISTRO DE SUEÑO",
                    style: TextStyle(
                        color: Color.fromRGBO(115, 112, 108, 10),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 8),
                  )
                ],
              ),
            ),
            ////////////////////////////////////////////////////////////
            Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/exercises');
                        },
                        child: Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/ilustraciones/respiración.png'),
                                ),
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "EJERCICIOS DE RESPIRACIÓN",
                        style: TextStyle(
                            color: Color.fromRGBO(115, 112, 108, 10),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 8),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/learn');
                        },
                        child: Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/ilustraciones/más info.png'),
                                ),
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "APRENDER ALGO NUEVO",
                        style: TextStyle(
                            color: Color.fromRGBO(115, 112, 108, 10),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 8),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/record_exercises');
                        },
                        child: Container(
                            height: 130,
                            width: 140,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/ilustraciones/ejercicios físicos.png'),
                                ),
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "REGISTRO DE EJERCICIOS FÍSICOS",
                        style: TextStyle(
                            color: Color.fromRGBO(115, 112, 108, 10),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 8),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/graph');
                        },
                        child: Container(
                            height: 80,
                            width: 140,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/ilustraciones/graficas.png'),
                                ),
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "GRÁFICAS",
                        style: TextStyle(
                            color: Color.fromRGBO(115, 112, 108, 10),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 8),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}
