import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/pages/objective_components/new_objetctive.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

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
  List<dynamic> goalsList = [];
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  Iterable<dynamic> goalInit = Iterable.empty();
  Iterable<dynamic> goalDone = Iterable.empty();
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    goalsList =
        await dataBaseHelper.getGoalsRecord(widget.idSend, name, password);

    print("goalsList: " + goalsList.toString());
    print("first: " + goalsList[0].toString());
    print("startDate first: " + goalsList[0]["startDate"].toString());
    print("size: " + goalsList.length.toString());
    goalInit = goalsList.where((element) => element["status"] == "pendiente");
    goalDone = goalsList.where((element) => element["status"] == "completado");
    print("los valores pendientes son: " + goalInit.toString());
    setState(() {});
  }

  //convert string to int
  //lista vacia  mensaje de error
  @override
  void initState() {
    super.initState();
    init();
  }

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
                  child: BackgroundImage('assets/fondos/objetivo.png'),
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
                                        child: IconButton(
                                      icon: Image.asset(
                                          'assets/icons/add goals.png'),
                                      iconSize: 20,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewObjetivePage(
                                                        widget.idSend)));
                                      },
                                    ))
                                  ],
                                ),
                                PendingChart(context),
                                SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ObjectiveInfo(
                                                        widget.idSend, "19")));
                                      },
                                      child: PendingChart(context),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                H1Label("Objetivos Terminados"),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: DoneChart(context),
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

  Widget PendingChart(BuildContext context) {
    List<Color> colors = [
      Color.fromRGBO(186, 152, 209, 10),
      Color.fromRGBO(106, 168, 231, 10),
      Color.fromRGBO(156, 212, 176, 10)
    ];
    Color col0r = Color.fromARGB(0, 137, 137, 218);
    var type;
    @override
    initState() {
      type = '';
    }

    setState(() {
      if (type == 'largo plazo') {
        col0r = Color.fromRGBO(156, 212, 176, 10);
      } else if (type == 'mediano plazo') {
        col0r = Color.fromRGBO(106, 168, 231, 10);
      } else {
        col0r = Color.fromRGBO(186, 152, 209, 10);
      }
    });

    return Column(
      children: [
        for (int i = 0; i < goalInit.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                            color: col0r,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            goalInit.elementAt(i)["type"].toString(),
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(goalInit.elementAt(i)["message"])),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: PopupMenuButton<String>(
                                enabled: true,
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
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: "Modificar",
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.edit,
                                            color: Color.fromRGBO(
                                                139, 168, 194, 10),
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
                                              style: TextStyle(
                                                  color: Colors.redAccent)),
                                        ),
                                      )
                                    ]))
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

  Widget DoneChart(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < goalDone.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "duracion",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(goalDone.elementAt(i)["message"])),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: PopupMenuButton<String>(
                                enabled: false,
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
                                        value: "Modificar",
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.edit,
                                            color: Color.fromRGBO(
                                                139, 168, 194, 10),
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
                                              style: TextStyle(
                                                  color: Colors.redAccent)),
                                        ),
                                      )
                                    ]))
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
  final String goalId;
  ObjectiveInfo(this.idSend, this.goalId);
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.8,
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Text(
                                              "a",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            )),
                                      ),
                                      Flexible(child: Text("a")),
                                    ],
                                  ),
                                ),
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
