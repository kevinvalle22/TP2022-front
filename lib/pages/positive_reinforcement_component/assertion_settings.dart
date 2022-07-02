import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/cupertino_switch.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/pages/positive_reinforcement_component/positive_reinforcement.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';

class AssertionSettings extends StatefulWidget {
  final String idSend;

  AssertionSettings(this.idSend);
  @override
  State<AssertionSettings> createState() => _AssertionSettingsState();
}

class _AssertionSettingsState extends State<AssertionSettings> {
  bool _switchValue1 = true;
  bool lunes = false;
  bool martes = false;
  bool miercoles = false;
  bool jueves = false;
  bool viernes = false;
  bool sabado = false;
  bool domingo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              child: Stack(
            children: <Widget>[
              Container(child: BackgroundImage('assets/2.jpg')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TitleHeader("Afirmaciones"),
                    H1Label("Modificar afirmación"),
                    Cupertino(),
                    H1Label("Afirmaciones recomendadas"),
                    ListContainer()
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget Cupertino() {
    return Container(
      width: MediaQuery.of(context).size.width*0.85,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
          ],
          color: Color.fromRGBO(226, 238, 239, 10),
          borderRadius: BorderRadius.circular(9.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  child: TextField(
                    //controller: message,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusColor: const Color.fromRGBO(146, 150, 187, 10),
                        hintText: "Escribe tu afirmación ...",
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(146, 150, 187, 10)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 3,
                              color: Color.fromRGBO(232, 227, 238, 10)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                CupertinoSwitch(
                  value: _switchValue1,
                  onChanged: (value) {
                    _switchValue1 = value;
                    setState(() {
                      value = false;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (lunes == false) {
                                      lunes = true;
                                      lunes =
                                          true;
                                    } else {
                                      lunes = false;
                                      lunes =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: lunes
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("L",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: lunes
                                                ? Colors.white
                                                : Colors.black))),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // ignore: prefer_const_constructors
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (martes == false) {
                                      martes = true;
                                      martes =
                                          true;
                                    } else {
                                      martes = false;
                                      martes =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: martes
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: martes
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (miercoles == false) {
                                      miercoles = true;
                                      miercoles =
                                          true;
                                    } else {
                                      miercoles = false;
                                      miercoles =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                        color: miercoles
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("M",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: miercoles
                                                ? Colors.white
                                                : Colors.black))),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (jueves == false) {
                                      jueves = true;
                                      jueves =
                                          true;
                                    } else {
                                      jueves = false;
                                      jueves =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: jueves
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    "J",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: jueves
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (viernes == false) {
                                      viernes = true;
                                      viernes =
                                          true;
                                    } else {
                                      viernes = false;
                                      viernes =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color:viernes
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("V",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: viernes
                                                ? Colors.white
                                                : Colors.black))),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (sabado == false) {
                                      sabado = true;
                                      sabado =
                                          true;
                                    } else {
                                      sabado = false;
                                      sabado =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: sabado
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    "S",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: sabado
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (domingo == false) {
                                      domingo = true;
                                      domingo =
                                          true;
                                    } else {
                                      domingo = false;
                                      domingo =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: domingo
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("D",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: domingo
                                                ? Colors.white
                                                : Colors.black))),
                              ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(6.0),
                  decoration: timeBoxDecoration(),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "07:15 AM",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width - 150,
              child: RaisedButton(
                color: const Color.fromRGBO(104, 174, 174, 6),
                onPressed: () async {
                  //Affirmation affirmation = Affirmation();
                  var userName = await UserSecureStorage.getUsername();
                  var password = await UserSecureStorage.getPassword();
                  var formatter = DateFormat('yyyy-MM-dd HH:mm');
                  /*affirmation.affirmationDate = selectedDayString;
                    affirmation.message = message.text;
                    affirmation.mondayActive = true;
                    affirmation.tuesdayActive = true;
                    affirmation.wednesdayActive = true;
                    affirmation.thursdayActive = true;
                    affirmation.fridayActive = true;
                    affirmation.saturdayActive = true;
                    affirmation.sundayActive = true;
                    affirmation = await dataBaseHelper.createAffirmation(
                        widget.idSend,
                        userName.toString(),
                        password.toString(),
                        affirmation);*/
                  /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PositiveReinforcementPage(widget.idSend)));*/
                },
                child: Text(
                  "MODIFICAR AFIRMACIÓN",
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
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Color.fromRGBO(107, 174, 174, 10), shape: BoxShape.circle);
  }

  BoxDecoration timeBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(107, 174, 174, 10),
      borderRadius: BorderRadius.circular(25),
    );
  }

  Widget ListContainer() {
    List<String> favorites = [
      '"Yo estoy feliz con quien soy aqui y ahora."',
      '"Celebraré cada meta que logre con gratitud y alegría."',
      '"Soy feliz y libre porque en el viaje."',
      '"Soy capaz. Tengo potencial para triunfar."',
      '"Creo en un mundo libre de estrés para mi."',
      '"Mi ansiedad no controla mi vida. Yo la controlo."',
      '"Todo va a estar bien."'
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.3), blurRadius: 3)
        ], color: Colors.white, borderRadius: BorderRadius.circular(9.0)),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                for (int i = 0; i < favorites.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Color.fromRGBO(219, 167, 138, 10),
                        ),
                        Flexible(
                          child: Text(
                            favorites[i].toString(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
