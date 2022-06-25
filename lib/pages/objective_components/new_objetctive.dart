import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'objective.dart';

//void main() => runApp(NewObjetivePage());

class NewObjetivePage extends StatefulWidget {
  final String idSend;

  NewObjetivePage(this.idSend);
  @override
  State<NewObjetivePage> createState() => _NewObjetivePageState();
}

class _NewObjetivePageState extends State<NewObjetivePage> {
  TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: BackgroundImage('assets/fondos/objetivo.png'),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TitleHeader("Nuevo Objetivo"),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: Column(
                        children: <Widget>[
                          H1Label("Objetivo"),
                          InputLabell("Escribir objetivo ...",),
                          H1Label("Tipo de Objetivo"),
                          TagsLabelObjective(),
                          H1Label("Plan de Acción"),
                          Container(
                            child: InputLabell(
                              "¿Cuál será tu primer paso?",
                            ),
                          ),
                          Container(
                            child: InputLabell("¿Qué harás para cumplirlo?"),
                          ),
                          Container(
                            child:
                                InputLabell("¿Cómo controlarás tu constancia?"),
                          ),
                          Buttom("CREAR OBJETIVO"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height / 3.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/pantallas/nuevo objetivo.png'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
    );
  }

  Widget InputLabell(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height * 0.05,
        //color: Colors.white,
        decoration: BoxDecoration(
            color: Color.fromRGBO(245, 242, 250, 10),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                //controller: dateController,
                dragStartBehavior: DragStartBehavior.start,
                decoration: InputDecoration.collapsed(hintText: text),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Buttom(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 300,
        height: 50,
        child: RaisedButton(
          color: Color.fromRGBO(107, 174, 174, 10),
          onPressed: () {
            Alert(
              context: context,
              type: AlertType.success,
              title: "CREACIÓN EXITOSA",
              desc: "¡Se guardó con éxito su objetivo!",
              buttons: [
                DialogButton(
                  child: Text(
                    "COOL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ObjectivePage(widget.idSend)));
                  },
                  width: 120,
                )
              ],
            ).show();
          },
          child: Text(text,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}
