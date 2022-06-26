// ignore_for_file: deprecated_member_use, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

//void main() => runApp(PositveReinforcementPage());

class PositiveReinforcementPage extends StatefulWidget {
  final String idSend;

  PositiveReinforcementPage(this.idSend);
  @override
  State<PositiveReinforcementPage> createState() =>
      _PositiveReinforcementPageState();
}

class _PositiveReinforcementPageState extends State<PositiveReinforcementPage> {
  String afirm = '';
  int cont = 0;
  int cont2 = 0;
  Color buttonColor = Colors.black;
  List<String> lista = <String>[];
  bool _switchValue = false;
  bool _switchValue2 = true;
  bool aasdaads = false;
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<dynamic> affirmationsList = [];
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    affirmationsList =
        await dataBaseHelper.getAffirmations(widget.idSend, name, password);

    print("sleepList: " + affirmationsList.toString());
    print("first: " + affirmationsList[0].toString());
    print("affirmationDate first: " +
        affirmationsList[0]["affirmationDate"].toString());
    print("size: " + affirmationsList.length.toString());

    //convert string to int
    //lista vacia  mensaje de error

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  bool x = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(child: Cuerpo(context)),
      bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
    );
  }

  Widget AffimtationChart(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < affirmationsList.length; i++)
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.1), blurRadius: 3)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite,
                              color: Color.fromRGBO(219, 106, 106, 1)),
                        ),
                        Expanded(
                          child: Text(
                            affirmationsList[i]["message"].toString(),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        CupertinoSwitch(
                          value: _switchValue,
                          onChanged: (value) {
                            _switchValue = value;
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: affirmationsList[i]["mondayActive"]
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text("L",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: affirmationsList[i]
                                                  ["mondayActive"]
                                              ? Colors.white
                                              : Colors.black))),
                              // ignore: prefer_const_constructors
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: affirmationsList[i]["tuesdayActive"]
                                        ? Color.fromRGBO(137, 132, 193, 1)
                                        : Colors.transparent,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "M",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: affirmationsList[i]["tuesdayActive"]
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                      color: affirmationsList[i]
                                              ["wednesdayActive"]
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text("M",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: affirmationsList[i]
                                                  ["wednesdayActive"]
                                              ? Colors.white
                                              : Colors.black))),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: affirmationsList[i]["thursdayActive"]
                                        ? Color.fromRGBO(137, 132, 193, 1)
                                        : Colors.transparent,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "J",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: affirmationsList[i]
                                              ["thursdayActive"]
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: affirmationsList[i]["fridayActive"]
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text("V",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: affirmationsList[i]
                                                  ["fridayActive"]
                                              ? Colors.white
                                              : Colors.black))),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: affirmationsList[i]["saturdayActive"]
                                        ? Color.fromRGBO(137, 132, 193, 1)
                                        : Colors.transparent,
                                    shape: BoxShape.circle),
                                child: Text(
                                  "S",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: affirmationsList[i]
                                              ["saturdayActive"]
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: affirmationsList[i]["sundayActive"]
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text("D",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: affirmationsList[i]
                                                  ["sundayActive"]
                                              ? Colors.white
                                              : Colors.black))),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.all(8.0),
                          decoration: timeBoxDecoration(),
                          child: int.parse(affirmationsList[i]
                                          ["affirmationDate"]
                                      .toString()
                                      .substring(11, 13)) >
                                  12
                              ? Row(
                                  children: <Widget>[
                                    Text(
                                      (int.parse(affirmationsList[i][
                                                              "affirmationDate"]
                                                          .toString()
                                                          .substring(11, 13))
                                                      .toInt() -
                                                  12)
                                              .toString() +
                                          affirmationsList[i]["affirmationDate"]
                                              .toString()
                                              .substring(13, 16) +
                                          " PM",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
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
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      (int.parse(affirmationsList[i]
                                                          ["affirmationDate"]
                                                      .toString()
                                                      .substring(11, 13))
                                                  .toInt())
                                              .toString() +
                                          affirmationsList[i]["affirmationDate"]
                                              .toString()
                                              .substring(13, 16) +
                                          " AM",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
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
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Color.fromRGBO(137, 132, 193, 1), shape: BoxShape.circle);
  }

  BoxDecoration timeBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(137, 132, 193, 1),
      borderRadius: BorderRadius.circular(20),
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
                    "AÑADIR AFIRMACION",
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

  Widget Cuerpo(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/fondos/afirmaciones-reforzamiento.png'),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
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
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: const Text("Afirmaciones personalizadas",
                            style: TextStyle(
                                color: Color.fromRGBO(146, 150, 187, 10),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      CustomAffirmattons(context),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: const Text("Mis Afirmaciones",
                            style: TextStyle(
                                color: Color.fromRGBO(146, 150, 187, 10),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: SizedBox(
                          child: AffimtationChart(context),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: const Text("Configuración",
                            style: TextStyle(
                                color: Color.fromRGBO(146, 150, 187, 10),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.1),
                                  blurRadius: 3)
                            ],
                            color: Color.fromRGBO(250, 233, 207, 1),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  "Recibir afirmaciones diarias.",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              CupertinoSwitch(
                                value: _switchValue2,
                                onChanged: (value) {
                                  /*
                    _switchValue2 = value;
                    if(_switchValue2==false)
                    {
                      setState(() {
                        _switchValue2=true;
                        aasdaads = true;
                      });
                    }
                    else
                    {
                      setState(() {
                        _switchValue2=false;
                        aasdaads = false;
                      });
                    }*/
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        )
      ],
    );
  }
}
