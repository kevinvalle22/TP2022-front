import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/pages/objective_components/new_objetctive.dart';

import '../home.dart';

//void main() => runApp(ObjectivePage());

class ObjectivePage extends StatefulWidget {
  final String idSend;

  ObjectivePage(this.idSend);

  @override
  State<ObjectivePage> createState() => _ObjectivePage();
}

class _ObjectivePage extends State<ObjectivePage> {
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                child: Stack(
              children: <Widget>[
                Container(
                  child: BackgroundImage('assets/7.jpg'),
                ),
                Column(
                  children: <Widget>[
                    TitleHeader("Objetivos"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    H1Label("Mis objetivos"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(147, 150, 186, 10),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewObjetivePage(
                                                              widget.idSend)));
                                            },
                                            child: Icon(
                                              Icons.add_to_photos,
                                              color: Colors.white,
                                            )))
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ObjectiveInfo(widget.idSend)));
                                  },
                                  child: Container(
                                    child: Contenedor(
                                      name: "Salud física",
                                      description:
                                          "Hacer ejercicios físicos constantemente.",
                                      indexDuration: 2,
                                      idSend: widget.idSend,
                                      enable: true,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                H1Label("Objetivos Terminados"),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: ContenedorTerminado(
                                    name: "Salud física",
                                    description:
                                        "Hacer ejercicios físicos constantemente.",
                                    indexDuration: 2,
                                    idSend: widget.idSend,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                )
              ],
            )),
          ),
        ),
        bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
      ),
    );
  }
}

class Contenedor extends StatefulWidget {
  final String idSend;
  Contenedor(
      {required this.name,
      required this.description,
      this.indexDuration = 0,
      required this.idSend,
      required this.enable});

  String name;
  String description;
  int indexDuration;
  bool enable = true;
  @override
  State<Contenedor> createState() => _ContenedorState();
}

class _ContenedorState extends State<Contenedor> {
  var duration = ["Corto Plazo", "Mediano Plazo", "Largo Plazo"];

  List<Color> colors = [
    Color.fromRGBO(186, 152, 209, 10),
    Color.fromRGBO(106, 168, 231, 10),
    Color.fromRGBO(156, 212, 176, 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: MediaQuery.of(context).size.width / 2.8,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors[widget.indexDuration],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    duration[widget.indexDuration],
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(widget.description)),
                Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: PopupMenuButton<String>(
                        enabled: widget.enable,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tooltip: "Opciones",
                        onSelected: (String value) {
                          if (value == "Modificar") {
                            /*dataBaseHelper.deleteReminder(
                                          remindersList[i]['id']);*/
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ObjectiveMod(widget.idSend)));
                          }
                        },
                        //padding: EdgeInsets.zero,
                        icon: Icon(Icons.more_horiz),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: "Completado",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    "Completado",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: "Modificar",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.edit,
                                    color: Color.fromRGBO(139, 168, 194, 10),
                                  ),
                                  title: Text("Modificar",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              139, 168, 194, 10))),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: "Eliminar",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  title: Text("Eliminar",
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                ),
                              )
                            ]))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ContenedorTerminado extends StatefulWidget {
  final String idSend;
  ContenedorTerminado(
      {required this.name,
      required this.description,
      this.indexDuration = 0,
      required this.idSend});

  String name;
  String description;
  int indexDuration;

  @override
  State<ContenedorTerminado> createState() => _ContenedorTerminadoState();
}

class _ContenedorTerminadoState extends State<ContenedorTerminado> {
  var duration = ["Corto Plazo", "Mediano Plazo", "Largo Plazo"];

  List<Color> colors = [
    Color.fromRGBO(186, 152, 209, 10),
    Color.fromRGBO(106, 168, 231, 10),
    Color.fromRGBO(156, 212, 176, 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(251, 249, 255, 10),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: MediaQuery.of(context).size.width / 2.8,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors[widget.indexDuration],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    duration[widget.indexDuration],
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(widget.description)),
                Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: PopupMenuButton<String>(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tooltip: "Opciones",
                        onSelected: (String value) {
                          if (value == "Modificar") {
                            /*dataBaseHelper.deleteReminder(
                                          remindersList[i]['id']);*/
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ObjectiveMod(widget.idSend)));
                          }
                        },
                        //padding: EdgeInsets.zero,
                        icon: Icon(Icons.more_horiz),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: "Completado",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    "Completado",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: "Modificar",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.edit,
                                    color: Color.fromRGBO(139, 168, 194, 10),
                                  ),
                                  title: Text("Modificar",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              139, 168, 194, 10))),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: "Eliminar",
                                child: ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  title: Text("Eliminar",
                                      style:
                                          TextStyle(color: Colors.redAccent)),
                                ),
                              )
                            ]))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ObjectiveMod extends StatefulWidget {
  final String idSend;

  ObjectiveMod(this.idSend);
  @override
  State<ObjectiveMod> createState() => _ObjectiveModState();
}

class _ObjectiveModState extends State<ObjectiveMod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Stack(
            children: <Widget>[
              Container(
                child: BackgroundImage('assets/7.jpg'),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TitleHeader("Objetivos"),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                H1Label("Mi objetivo"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: InputLabell(),
                            ),
                            TagsLabelObjective(),
                            SizedBox(
                              height: 10,
                            ),
                            H1Label("Plan de Acción"),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text("¿Cuál será tu primer paso?")),
                            Container(
                              child: InputLabell(),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text("¿Qué harás para cumplirlo?")),
                            Container(
                              child: InputLabell(),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child:
                                    Text("¿Cómo controlarás tu constancia?")),
                            Container(
                              child: InputLabell(),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height / 3.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/pantallas/objetivos.png'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              )
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
    );
  }

  Widget InputLabell() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
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
                decoration: InputDecoration.collapsed(hintText: ""),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ObjectiveInfo extends StatefulWidget {
  final String idSend;

  ObjectiveInfo(this.idSend);
  @override
  State<ObjectiveInfo> createState() => _ObjectiveInfoState();
}

class _ObjectiveInfoState extends State<ObjectiveInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Stack(
            children: <Widget>[
              Container(
                child: BackgroundImage('assets/7.jpg'),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TitleHeader("Objetivos"),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                H1Label("Mi objetivo"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Contenedor(
                                name: "Salud física",
                                description:
                                    "Hacer ejercicios físicos constantemente.",
                                indexDuration: 1,
                                idSend: widget.idSend,
                                enable: false,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            H1Label("Plan de Acción"),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text("¿Cuál será tu primer paso?")),
                            Container(
                              child: InputLabell(),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text("¿Qué harás para cumplirlo?")),
                            Container(
                              child: InputLabell(),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child:
                                    Text("¿Cómo controlarás tu constancia?")),
                            Container(
                              child: InputLabell(),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height / 3.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/pantallas/objetivos.png'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              )
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
    );
  }

  Widget InputLabell() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
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
                decoration: InputDecoration.collapsed(hintText: ""),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
