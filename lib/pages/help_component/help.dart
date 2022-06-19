// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
//import 'package:flutter_dialpad/flutter_dialpad.dart';

class HelpPage extends StatefulWidget {
  final String idSend;

  HelpPage(this.idSend);
  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Cuerpo(context),
        bottomNavigationBar: BottomNavigation(idSend: widget.idSend));
  }

  Widget Cuerpo(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1,
                color: Color.fromRGBO(254, 246, 238, 10),
              ),
              Positioned(
                top: 50,
                child: Name(),
              ),
              Positioned(
                top: 120,
                width: 420,
                height: MediaQuery.of(context).size.height,
                child: Components(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget Name() {
    return IntrinsicWidth(
      child: Column(
        children: const [
          Text("Contactar personal",
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

  Widget Components(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: LineCrisis(context),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
          child: const Text("Consejos",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Tips(),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
          child: const Text("Afirmaciones",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Affirmations(),
        ),
      ],
    );
  }

  Widget LineCrisis(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: const Text("Línea de Crisis",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          child: DoctorCard(context),
        ),
      ],
    );
  }

  Widget DoctorCard(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
        ], color: Colors.white, borderRadius: BorderRadius.circular(9.0)),
        margin: const EdgeInsets.all(9.0),
        padding: const EdgeInsets.all(9.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.asset('assets/doctor.jpg'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("MINSA",
                        style: Theme.of(context).textTheme.headline5!.apply(
                            color: Color.fromRGBO(72, 129, 129, 10),
                            fontWeightDelta: 5)),
                    const Text(
                      "Línea de emergencia",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(67, 58, 108, 10),
                                  width: .5),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.phone_in_talk),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TelefonoPage(widget.idSend)));
                              },
                              color: Color.fromRGBO(67, 58, 108, 10),
                            ),
                          ),
                        ),
                        const Text(
                          "113",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(67, 58, 108, 10),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(67, 58, 108, 10),
                                  width: .5),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.watch_later_outlined),
                              onPressed: () {},
                              color: Color.fromRGBO(67, 58, 108, 10),
                            ),
                          ),
                        ),
                        Text(
                          "24 hrs.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(67, 58, 108, 10),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 2),
                      child: Text("Disponible"),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Tips() {
    return GestureDetector(
      child: Container(
        width: 340,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
        ], color: Colors.white, borderRadius: BorderRadius.circular(9.0)),
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: const [
                    Text(
                      "1. No es momento de tomar decisiones",
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                      Text("2. Habla con alguien"),
                    ],
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                      Text("3. Intenta mantenerte seguro"),
                    ],
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                      Text("4. Procura estar acompañado"),
                    ],
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: const [
                      Text("5. Evita consumir alcochol o drogas"),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget Affirmations() {
    return GestureDetector(
      child: Container(
        width: 340,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
        ], color: Colors.white, borderRadius: BorderRadius.circular(9.0)),
        padding: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: const [
                    Icon(
                      Icons.favorite,
                      color: Color.fromRGBO(219, 167, 138, 10),
                    ),
                    Flexible(
                      child: Text(
                        '"Puedo encontrar soluciones a mis problemas"',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(219, 167, 138, 10),
                      ),
                      Flexible(
                          child: Text(
                        '"Puedo encontrar nuevos propósitos"',
                        style: TextStyle(fontSize: 14),
                      )),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(219, 167, 138, 10),
                      ),
                      Flexible(
                          child: Text(
                        '"Mis pensamientos y emociones pueden cambiar"',
                        style: TextStyle(fontSize: 14),
                      )),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(219, 167, 138, 10),
                      ),
                      Flexible(
                          child: Text(
                        '"He salido de muchas batallas, esta vez también"',
                        style: TextStyle(fontSize: 14),
                      )),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(219, 167, 138, 10),
                      ),
                      Flexible(
                          child: Text(
                        '"Sé que ha sido duro, pero todavía te estoy animando"',
                        style: TextStyle(fontSize: 14),
                      )),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(219, 167, 138, 10),
                      ),
                      Flexible(
                          child: Text(
                        '"Soy capaz de cosas interesantes"',
                        style: TextStyle(fontSize: 14),
                      )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class TelefonoPage extends StatefulWidget {
  final String idSend;
  TelefonoPage(this.idSend);
  @override
  State<TelefonoPage> createState() => _TelefonoPageState();
}

class _TelefonoPageState extends State<TelefonoPage> {
  String display = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ListTile(
        leading: Icon(
          Icons.home,
          size: 40,
        ),
        trailing: Icon(
          Icons.person_outline,
          size: 40,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  display,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Container(
                width: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child:
                          Icon(Icons.person_add, size: 35, color: Colors.blue),
                    ),
                    InkWell(
                      onTap: () {
                        if (display.length != 0) {
                          setState(() {
                            display = display.substring(0, display.length - 1);
                          });
                        }
                      },
                      child: Icon(
                        Icons.backspace,
                        size: 35,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                dialPadButton(size, '1'),
                dialPadButton(size, '2'),
                dialPadButton(size, '3')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '4'),
                dialPadButton(size, '5'),
                dialPadButton(size, '6')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '7'),
                dialPadButton(size, '8'),
                dialPadButton(size, '9')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '*', color: Colors.grey),
                dialPadButton(size, '0'),
                dialPadButton(size, '#', color: Colors.grey)
              ],
            ),
            InkWell(
              child: Container(
                height: 80,
                width: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              onTap: (){
                //FlutterPhoneDirectCaller.callNumber(display);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget dialPadButton(Size size, String value, {Color? color}) {
    return InkWell(
      highlightColor: Colors.black45,
      onTap: () {
        setState(() {
          display = display + value;
        });
      },
      child: Container(
        height: size.height * 0.15,
        width: size.width * 0.33,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 0.025)),
        child: Center(
          child: Text(
            value,
            textScaleFactor: 1.0,
            style: TextStyle(
                color: color ?? Color.fromRGBO(87, 152, 228, 10),
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
