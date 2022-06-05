//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/models/User.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import '../ControllerEndpoints/endpoints.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Stack(
          children: <Widget>[
            BackgroundImage('assets/7.jpg'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Mi perfil",
                        style: TextStyle(
                            color: Color.fromRGBO(98, 89, 134, 10),
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold)),
                  ),

                  //Avatar y Nombre del Usuario

                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9),
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: box(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                color: Colors.white,
                                width: 5.0,
                              )),
                          child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage('assets/perfil.png')),
                        ),
                        Text(
                          "Emilio Jones",
                          style: TextStyle(
                              color: Color.fromRGBO(98, 89, 134, 10),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  H1Label("Usuario:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.userName,
                        style: style(),
                      ),
                    ),
                  ),
                  H1Label("Email:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.email,
                        style: style(),
                      ),
                    ),
                  ),
                  H1Label("Número de celular:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.phone,
                        style: style(),
                      ),
                    ),
                  ),
                  H1Label("Contraseña:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "*********",
                        style: style(),
                      ),
                    ),
                  ),
                  H1Label("Universidad:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.university,
                        style: style(),
                      ),
                    ),
                  ),
                  H1Label("Provincia:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.province,
                        style: style(),
                      ),
                    ),
                  ),
                  H1Label("Distrito:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.district,
                        style: style(),
                      ),
                    ),
                  ),
                  H1Label("Usuario:"),
                  Container(
                    width: 350,
                    height: 50,
                    decoration: box(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "a",
                        style: style(),
                      ),
                    ),
                  ),
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

TextStyle style() {
  return TextStyle(color: Color.fromRGBO(150, 140, 182, 10), fontSize: 20);
}
