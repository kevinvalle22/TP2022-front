//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/models/User.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/pages/sign_in.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import '../utils/endpoints.dart';

// pasar como argumento el contexto dataBaseHelper
class ProfilePage extends StatefulWidget {
  final String idSend;

  ProfilePage(this.idSend);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user = new User();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //using dataBaseHelper from main.dart
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  // user info
  var userInfo;

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    user = await dataBaseHelper.getUser(widget.idSend, name, password);

    setState(() {
      // get id from user

      print("El usuario con info se ha logeado" + user.userName);
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

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
    double ancho = MediaQuery.of(context).size.width * 0.1;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
              child: Stack(
            children: <Widget>[
              BackgroundImage('assets/fondos/profile.png'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    //boton eliminar usuario
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              final name =
                                  await UserSecureStorage.getUsername() ?? '';
                              final password =
                                  await UserSecureStorage.getPassword() ?? '';
                              await dataBaseHelper.deleteUser(
                                  widget.idSend, name, password);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                          ),
                        ],
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      child: Text("Mi perfil",
                          style: TextStyle(
                              color: Color.fromRGBO(98, 89, 134, 10),
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    H1Label("Usuario:"),
                    Container(
                      width: 350,
                      height: ancho,
                      decoration: box(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.userName,
                          style: style(context),
                        ),
                      ),
                    ),
                    H1Label("Email:"),
                    Container(
                      width: 350,
                      height: ancho,
                      decoration: box(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.email,
                          style: style(context),
                        ),
                      ),
                    ),
                    H1Label("Número de celular:"),
                    Container(
                      width: 350,
                      height: ancho,
                      decoration: box(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "(+51)" + " " + user.phone,
                          style: style(context),
                        ),
                      ),
                    ),
                    H1Label("Contraseña:"),
                    Container(
                      width: 350,
                      height: ancho,
                      decoration: box(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "*********",
                          style: style(context),
                        ),
                      ),
                    ),
                    H1Label("Universidad:"),
                    Container(
                      width: 350,
                      height: ancho,
                      decoration: box(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.university,
                          style: style(context),
                        ),
                      ),
                    ),
                    H1Label("Provincia:"),
                    Container(
                      width: 350,
                      height: ancho,
                      decoration: box(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.province,
                          style: style(context),
                        ),
                      ),
                    ),
                    H1Label("Distrito:"),
                    Container(
                      width: 350,
                      height: ancho,
                      decoration: box(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.district,
                          style: style(context),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: FlatButton(
                          onPressed: () {},
                          child: Text("ELIMINAR MI CUENTA",
                              style: TextStyle(
                                  color: Color.fromRGBO(104, 110, 174, 10),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              )
            ],
          )),
        ),
        bottomNavigationBar: BottomNavigation(
          isTheSameProfile: true,
          profileColorIcon: false,
          idSend: widget.idSend,
        ),
      ),
    );
  }
}

BoxDecoration box() {
  return BoxDecoration(
      color: Color.fromRGBO(200, 191, 231, 10),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(200, 191, 231, 10).withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
        )
      ]);
}

TextStyle style(BuildContext context) {
  return TextStyle(
      color: Color.fromRGBO(150, 140, 182, 10),
      fontSize: MediaQuery.of(context).size.width * 0.04);
}
