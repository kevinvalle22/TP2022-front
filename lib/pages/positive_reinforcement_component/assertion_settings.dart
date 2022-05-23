import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/cupertino_switch.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/pages/positive_reinforcement_component/positive_reinforcement.dart';

class AssertionSettings extends StatefulWidget {
  @override
  State<AssertionSettings> createState() => _AssertionSettingsState();
}

class _AssertionSettingsState extends State<AssertionSettings> {
  bool _switchValue1 = true;
  bool _switchValue2 = true;
  bool _switchValue3 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: <Widget>[
            Container(child: BackgroundImage('assets/2.jpg')),
            Column(
              children: <Widget>[
                TitleHeader("Afirmaciones"),
                H1Label("Configuración"),
                Cupertino(),
                H1Label("Lista de afirmaciones"),
                ListContainer()
              ],
            )
          ],
        )),
      ),
    );
  }

  Widget Cupertino() {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
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
                Text(
                  "Incluir afirmaciones random",
                  style: TextStyle(fontSize: 18),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Incluir afirmaciones favoritas",
                  style: TextStyle(fontSize: 18),
                ),
                CupertinoSwitch(
                  value: _switchValue2,
                  onChanged: (value) {
                    _switchValue2 = value;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recibir afirmaciones diarias",
                  style: TextStyle(fontSize: 18),
                ),
                CupertinoSwitch(
                  value: _switchValue3,
                  onChanged: (value) {
                    _switchValue3 = value;
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
                          decoration: myBoxDecoration(),
                          child: Text("L",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      // ignore: prefer_const_constructors
                      Text(
                        "M",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: myBoxDecoration(),
                          child: Text("M",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      Text(
                        "J",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: myBoxDecoration(),
                          child: Text("V",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      Text(
                        "S",
                        style: TextStyle(fontSize: 18),
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
                        "07:15 AM",
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
            )
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
      '"Yo estoy feliz con quien soy aqui y ahora"',
      '"Celebraré cada meta que logre con gratitud y alegría"',
      '"Soy feliz y libre porque en el viaje"',
      '"Soy capaz. Tengo potencial para triunfar"',
      '"Creo en un mundo libre de estrés para mi"'
    ];
    List<String> random = [
      '"Mi presencia es mi poder"',
      '"Todo va a estar bien"',
      '"Respiro, estoy serena y tranquila"',
      '"Soy valiente"',
      '"Mi ansiedad no controla mi vida. Yo la controlo"',
      '"Estoy a salvo y en mi mundo todo es bueno"',
      '"Mis pensamientos están llenos de positivada"'
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.white.withOpacity(.1), blurRadius: 3)
            ],
            color: Color.fromRGBO(254, 227, 211, 10),
            borderRadius: BorderRadius.circular(9.0)),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (_switchValue2 == true)
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
              if (_switchValue1 == true)
                for (int i = 0; i < random.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Color.fromRGBO(219, 167, 138, 10),
                        ),
                        Flexible(
                          child: Text(
                            random[i].toString(),
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
