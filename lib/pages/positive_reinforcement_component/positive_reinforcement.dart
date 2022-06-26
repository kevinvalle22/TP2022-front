// ignore_for_file: deprecated_member_use, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/models/Affimation.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

import '../home.dart';

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
  List<String> lista = <String>[];
  bool _switchValue = false;
  bool _switchValue2 = false;
  bool aasdaads = false;
  CalendarFormat format = CalendarFormat.month;
  String selectedDayString =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  bool lunes = false;
  bool martes = false;
  bool miercoles = false;
  bool jueves = false;
  bool viernes = false;
  bool sabado = false;
  bool domingo = false;

  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<dynamic> affirmationsList = [];
  final TextEditingController message = TextEditingController();
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Quieres salir de esta sección?"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(widget.idSend))),
                  child: Text("Si")),
            ],
          ));
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    affirmationsList =
        await dataBaseHelper.getAffirmations(widget.idSend, name, password);
    print("affirmationDate first: " +
        affirmationsList[0]["affirmationDate"].toString());


    //convert string to int
    //lista vacia  mensaje de error
    print(selectedDayString);
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
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child: Cuerpo(context)),
        bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
      ),
    );
  }

  Widget AffimtationChart(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < affirmationsList.length; i++)
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (lunes == false) {
                                      lunes = true;
                                      affirmationsList[i]["mondayActive"] =
                                          true;
                                    } else {
                                      lunes = false;
                                      affirmationsList[i]["mondayActive"] =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: affirmationsList[i]
                                                ["mondayActive"]
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("L",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: affirmationsList[i]
                                                    ["mondayActive"]
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
                                      affirmationsList[i]["tuesdayActive"] =
                                          true;
                                    } else {
                                      martes = false;
                                      affirmationsList[i]["tuesdayActive"] =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: affirmationsList[i]
                                              ["tuesdayActive"]
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: affirmationsList[i]
                                              ["tuesdayActive"]
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
                                      affirmationsList[i]["wednesdayActive"] =
                                          true;
                                    } else {
                                      miercoles = false;
                                      affirmationsList[i]["wednesdayActive"] =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                        color: affirmationsList[i]
                                                ["wednesdayActive"]
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("M",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: affirmationsList[i]
                                                    ["wednesdayActive"]
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
                                      affirmationsList[i]["thursdayActive"] =
                                          true;
                                    } else {
                                      jueves = false;
                                      affirmationsList[i]["thursdayActive"] =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: affirmationsList[i]
                                              ["thursdayActive"]
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    "J",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: affirmationsList[i]
                                                ["thursdayActive"]
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
                                      affirmationsList[i]["fridayActive"] =
                                          true;
                                    } else {
                                      viernes = false;
                                      affirmationsList[i]["fridayActive"] =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: affirmationsList[i]
                                                ["fridayActive"]
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("V",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: affirmationsList[i]
                                                    ["fridayActive"]
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
                                      affirmationsList[i]["saturdayActive"] =
                                          true;
                                    } else {
                                      sabado = false;
                                      affirmationsList[i]["saturdayActive"] =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: affirmationsList[i]
                                              ["saturdayActive"]
                                          ? Color.fromRGBO(137, 132, 193, 1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    "S",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: affirmationsList[i]
                                                ["saturdayActive"]
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
                                      affirmationsList[i]["sundayActive"] =
                                          true;
                                    } else {
                                      domingo = false;
                                      affirmationsList[i]["sundayActive"] =
                                          false;
                                    }
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: affirmationsList[i]
                                                ["sundayActive"]
                                            ? Color.fromRGBO(137, 132, 193, 1)
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Text("D",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: affirmationsList[i]
                                                    ["sundayActive"]
                                                ? Colors.white
                                                : Colors.black))),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 45,
                          padding: const EdgeInsets.all(6.0),
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
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                      size: 16,
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
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                      size: 16,
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
                controller: message,
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
                  onPressed: () async {
                    Affirmation affirmation = Affirmation();
                    var userName = await UserSecureStorage.getUsername();
                    var password = await UserSecureStorage.getPassword();
                    var formatter = DateFormat('yyyy-MM-dd HH:mm');
                    var a = DateTime.parse(selectedDayString);
                    selectedDayString =
                        formatter.format(a.add(Duration(days: 1)));
                    print(selectedDayString);
                    affirmation.affirmationDate = selectedDayString;
                    affirmation.message = message.text;
                    affirmation.mondayActive = true;
                    affirmation.tuesdayActive = false;
                    affirmation.wednesdayActive = true;
                    affirmation.thursdayActive = false;
                    affirmation.fridayActive = true;
                    affirmation.saturdayActive = false;
                    affirmation.sundayActive = true;
                    affirmation = await dataBaseHelper.createAffirmation(
                        widget.idSend,
                        userName.toString(),
                        password.toString(),
                        affirmation);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PositiveReinforcementPage(widget.idSend)));
                  },
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
                                  _switchValue = value;
                                  setState(() {
                                    _switchValue2 = value;
                                  });
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
