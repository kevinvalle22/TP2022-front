// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';

void main() => runApp(CalendarPage());

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cuerpo(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class Cuerpo extends StatefulWidget {
  Cuerpo({Key? key}) : super(key: key);

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/7.jpg'),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Header(),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          child: TableCalendar(
                            focusedDay: DateTime.now(),
                            firstDay: DateTime.now(),
                            lastDay: DateTime.now().add(Duration(days: 300)),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          child: MakeReminder(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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

  Widget MakeReminder(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
            ],
            color: Color.fromRGBO(128, 124, 183, 10),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recordatorio",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      focusColor: const Color.fromRGBO(146, 150, 187, 10),
                      hintText: "Escribe tu recortario ...",
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(146, 150, 187, 10)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3, color: Color.fromRGBO(232, 227, 238, 10)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Días y hora",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15,
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
                            decoration: myBoxDecoration(),
                            child: Text("L",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                        // ignore: prefer_const_constructors
                        Text(
                          "M",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: myBoxDecoration(),
                            child: Text("M",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                        Text(
                          "J",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: myBoxDecoration(),
                            child: Text("V",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                        Text(
                          "S",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: myBoxDecoration(),
                            child: Text("D",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    decoration: timeBoxDecoration(),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "05:15 AM",
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                height: 50,
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                  },
                  child: const Text("Crear Recordatorio",
                      style: TextStyle(
                          fontSize: 15.5,
                          color: Color.fromRGBO(107, 174, 174, 10),
                          fontWeight: FontWeight.bold)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
          SizedBox(
            height: 10,
          ),
          Text("Recordatorio",
              style: TextStyle(
                  color: Color.fromRGBO(67, 58, 108, 10),
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            width: 450,
            height: 10,
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
