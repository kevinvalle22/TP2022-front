import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/models/Goal.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';
import 'objective.dart';

//void main() => runApp(NewObjetivePage());

class NewObjetivePage extends StatefulWidget {
  final String idSend;

  NewObjetivePage(this.idSend);
  @override
  State<NewObjetivePage> createState() => _NewObjetivePageState();
}

class _NewObjetivePageState extends State<NewObjetivePage> {
  TextEditingController message = TextEditingController();
  TextEditingController actionPlan1 = TextEditingController();
  TextEditingController actionPlan2 = TextEditingController();
  TextEditingController actionPlan3 = TextEditingController();
  String selectedDayString = '';
  var selected;
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    //
  }

  @override
  void initState() {
    super.initState();
    init();
  }

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
                          InputLabell("Escribir objetivo ...", message),
                          H1Label("Tipo de Objetivo"),
                          TagContainer(context),
                          H1Label("Plan de Acción"),
                          Container(
                            child: InputLabell(
                                "¿Cuál será tu primer paso?", actionPlan1),
                          ),
                          Container(
                            child: InputLabell(
                                "¿Qué harás para cumplirlo?", actionPlan2),
                          ),
                          Container(
                            child: InputLabell(
                                "¿Cómo controlarás tu constancia?",
                                actionPlan3),
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

  Widget TagContainer(BuildContext context) {
    var duration = ["Corto Plazo", "Mediano Plazo", "Largo Plazo"];
    List<Color> colors = [
      Color.fromRGBO(186, 152, 209, 10),
      Color.fromRGBO(106, 168, 231, 10),
      Color.fromRGBO(156, 212, 176, 10)
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (int i = 0; i < duration.length; i++)
              GestureDetector(
                  onTap: () {
                    if (duration[0] == duration[i]) {
                      selected = "corto plazo";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            "$selected",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: colors[i],
                        ),
                      );
                      print(selected);
                    } else if (duration[1] == duration[i]) {
                      selected = "mediano plazo";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            "$selected",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: colors[i],
                        ),
                      );
                      print(selected);
                    } else if (duration[2] == duration[i]) {
                      selected = "largo plazo";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            "$selected",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: colors[i],
                        ),
                      );
                      print(selected);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors[i],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      duration[i],
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  Widget InputLabell(String text, TextEditingController textEditingController) {
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
                controller: textEditingController,
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
          onPressed: () async {
            var userName = await UserSecureStorage.getUsername();
            var password = await UserSecureStorage.getPassword();
            DateTime.now();
            Goal goal = Goal();
            goal.actionPlan1 = actionPlan1.text;
            goal.actionPlan2 = actionPlan2.text;
            goal.actionPlan3 = actionPlan3.text;
            goal.message = message.text;
            selectedDayString =
                DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
            goal.startDate = selectedDayString;
            goal.status = "pendiente";
            goal.type = selected;
            goal = await dataBaseHelper.createAGoalRecord(
                widget.idSend, userName.toString(), password.toString(), goal);
            if (goal == null) {
              Alert(
                context: context,
                type: AlertType.error,
                title: "CREACIÓN FALLIDA",
                desc: "Vuelva a guardar los datos completos, otra vez",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Volver",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    width: 120,
                  ),
                ],
              ).show();
            } else {
              Alert(
                context: context,
                type: AlertType.success,
                title: "CREACIÓN EXITOSA",
                desc: "¡Se guardó con éxito su objetivo!",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Aceptar",
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
                  ),
                ],
              ).show();
            }
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
