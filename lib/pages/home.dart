import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/pages/chat_component/chatbot.dart';
import 'package:tp2022_front/pages/diary_components/diary.dart';
import 'package:tp2022_front/pages/dream_component/dream_register.dart';
import 'package:tp2022_front/pages/exercises_components/exercises.dart';
import 'package:tp2022_front/pages/exercises_components/record_exercises.dart';
import 'package:tp2022_front/pages/graph_component/graph.dart';
import 'package:tp2022_front/pages/help_component/help.dart';
import 'package:tp2022_front/pages/learn_component/learn.dart';
import 'package:tp2022_front/pages/objective_components/objective.dart';
import 'package:tp2022_front/pages/positive_reinforcement_component/positive_reinforcement.dart';
import 'package:tp2022_front/pages/reminder_component/reminder.dart';
import 'package:tp2022_front/pages/sign_in.dart';
import 'package:tp2022_front/pages/test.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';

import '../utils/endpoints.dart';

class HomePage extends StatefulWidget {
  // get id from sign in page
  final String idSend;

  HomePage(this.idSend);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<dynamic> affirmationsList = [];
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Deseas cerrar Sesión?"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No")),
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage())),
                  child: Text("Si")),
            ],
          ));
  String afirm = '';
  int cont = 0;
  int cont2 = 0;
  Color buttonColor = Colors.black;
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    affirmationsList =
        await dataBaseHelper.getAffirmations(widget.idSend, name, password);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    print("el id del usuario logeado es el ${widget.idSend}");
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SafeArea(child: SingleChildScrollView(child: Cuerpo(context))),
        bottomNavigationBar: BottomNavigation(
          isTheSameHome: true,
          homeColorIcon: false,
          idSend: widget.idSend,
        ),
      ),
    );
    //}
  }

  Widget Cuerpo(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/fondos/home.png'),
          ),
        ),
      ),
      Components()
    ]);
  }

  Widget Components() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              child: Header(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Body(),
            )
          ],
        ),
      ),
    );
  }

  Widget Header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(child: Name()),
        Container(
          child: PhoneIcon(),
        )
      ],
    );
  }

  Widget Name() {
    return Text("Hola estudiante",
        style: TextStyle(
            color: Color.fromRGBO(67, 58, 108, 10),
            fontSize: 35.0,
            fontWeight: FontWeight.bold));
  }

  Widget PhoneIcon() {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HelpPage(widget.idSend)));
        },
        icon: Image.asset('assets/icons/contacto profesional.png'),
      );
    });
  }

  Widget Body() {
    return Builder(builder: (context) {
      return Column(
        children: [
          Container(
            child: const Text("¿Cómo te Sientes hoy?",
                style: TextStyle(
                    color: Color.fromRGBO(146, 150, 187, 10),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
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
          SizedBox(
            height: 5,
          ),
          Container(
            width: 300,
            height: 50,
            child: RaisedButton(
              color: Color.fromRGBO(107, 174, 174, 10),
              onPressed: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatBotPage(widget.idSend)));*/
              },
              child: const Text("¿TE GUSTARIA TOMAR UN TEST?",
                  style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Container(
            child: Affirmation(context),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Container(
            child: Reminder(context),
          ),
          Container(
            child: Activities(context),
          ),
        ],
      );
    });
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
    List<String> afirmaciones = <String>[];
    for (int i = 0; i < affirmationsList.length; i++) {
      afirmaciones.add(affirmationsList[i]['message']);
    }
    print(afirmaciones);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("Afirmaciones",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
              ],
              color: Color.fromRGBO(243, 212, 229, 10),
              borderRadius: BorderRadius.circular(9.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PositiveReinforcementPage(widget.idSend)));
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    // ignore: prefer_const_constructors
                    child: const Icon(Icons.more_horiz),
                  ),
                ),
                if (afirmaciones.length > 0) ...[
                  Container(
                    child: Text(
                      '"' + afirmaciones[cont2] + '."',
                      style: TextStyle(
                          color: Color.fromRGBO(67, 58, 108, 10),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ] else if (affirmationsList.isEmpty) ...[
                  Container(
                    child: Text(
                      "No hay afirmaciones",
                      style: TextStyle(
                          color: Color.fromRGBO(67, 58, 108, 10),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        alignment: Alignment.topRight,
                        icon: Image.asset(
                          'assets/icons/change.png',
                          width: 18,
                          height: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            afirm = '';
                            if (cont2 != affirmationsList.length - 1) {
                              buttonColor = Colors.black;
                              cont2++;
                            } else {
                              cont2 = 0;
                            }
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget Reminder(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("Objetivos, recordatorios y diario",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ObjectivePage(widget.idSend)));
                    },
                    child: Container(
                      child: Container(
                        height: 100,
                        width: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/ilustraciones/objetivos.png'),
                          ),
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
              /////////////////////////////////////////////////////////////////////
              ///
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReminderPage(widget.idSend)));
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
              //////////////////////////////////////////////////////////////////////////////

              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiaryPage(widget.idSend)));
                    },
                    child: Container(
                      height: 100,
                      width: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/ilustraciones/pensamientos.png'),
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
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget Activities(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("Sueño, respiración y actividades",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 5,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DreamRecordsPage(widget.idSend)));
                      },
                      child: Container(
                          height: 220,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/ilustraciones/sueño.png'),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ExercisesPage(widget.idSend)));
                          },
                          child: Container(
                              height: 100,
                              width: 90,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LearnPage(widget.idSend)));
                          },
                          child: Container(
                              height: 100,
                              width: 90,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecordExercisesPage(widget.idSend)));
                          },
                          child: Container(
                              height: 130,
                              width: 120,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GraphPage(widget.idSend)));
                          },
                          child: Container(
                              height: 80,
                              width: 120,
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
}
