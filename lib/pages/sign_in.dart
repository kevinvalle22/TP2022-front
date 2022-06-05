// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/ControllerEndpoints/endpoints.dart';
import 'package:tp2022_front/main.dart' as main;
import 'package:tp2022_front/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:tp2022_front/security/user_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //using dataBaseHelper from main.dart
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  final TextEditingController userName = new TextEditingController();

  final TextEditingController password = new TextEditingController();

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';

    setState(() {
      this.userName.text = name;
      this.password.text = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //evitar el error de botoom overflow by n pixels
      resizeToAvoidBottomInset: false,
      //el teclado no sobreponga los componentes
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Column(
          children: [Cuerpo(context)],
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget Cuerpo(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/2.jpg'),
              ),
            ),
          ),
          Positioned(
            top: 100,
            width: 420,
            height: 800,
            child: Components(),
          ),
          Positioned(
            top: 500,
            height: 335,
            width: 320,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/psychology-3609155-3016781.png'),
                ),
              ),
            ),
          )
        ])
      ],
    );
  }

// ignore: non_constant_identifier_names
  Widget Components() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Name(),
            UserField(),
            PasswordField(),
            BtnForgotPassword(),
            SignIn(),
            const SizedBox(height: 30),
            NewAccount()
          ],
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget Name() {
    return Container(
        alignment: Alignment.center,
        child: const Text("Iniciar Sesión",
            style: TextStyle(
                color: Color.fromRGBO(67, 58, 108, 10),
                fontSize: 35.0,
                fontWeight: FontWeight.bold)));
  }

// ignore: non_constant_identifier_names
  Widget UserField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
            fillColor: const Color.fromRGBO(232, 227, 238, 10),
            filled: true,
            focusColor: const Color.fromRGBO(146, 150, 187, 10),
            labelText: "Usuario",
            labelStyle:
                const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
            hintText: "Su usuario",
            hintStyle:
                const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
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
    );
  }

  Widget PasswordField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
            fillColor: const Color.fromRGBO(232, 227, 238, 10),
            filled: true,
            labelText: "Contraseña",
            labelStyle:
                const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
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
    );
  }

  Widget BtnForgotPassword() {
    //cambiar a boton
    return Container(
      alignment: Alignment.centerRight,
      // ignore: deprecated_member_use
      child: FlatButton(
          onPressed: () {},
          child: const Text("¿Olvidaste tu contraseña?",
              style: TextStyle(
                  color: Color.fromRGBO(146, 150, 187, 10), fontSize: 15.0))),
    );
  }

  Widget SignIn() {
    return Builder(builder: (context) {
      return Container(
        width: 320,
        height: 50,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: const Color.fromRGBO(104, 174, 174, 6),
          onPressed: () async {
            var auth = dataBaseHelper.authenticate(
                userName.text.trim(), password.text.trim());
            await UserSecureStorage.setUsername(userName.text);
            await UserSecureStorage.setPassword(password.text);
            await UserSecureStorage.setToken(auth.toString());

            int id = await dataBaseHelper.authenticateToGetId(
                userName.text.trim(), password.text.trim());
            // convertir a int el id
            await UserSecureStorage.setUserId(id.toString());

            // convertir a int el id

            String idSend = id.toString();
            print(id);
            // ir a la pantalla principal y mandar el id
            print(idSend);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage(idSend)));

            // print(auth);
          },
          child: const Text(
            "INICIAR SESIÓN",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    });
  }

// ignore: non_constant_identifier_names
  Widget NewAccount() {
    return Builder(builder: (context) {
      return SizedBox(
        width: 320,
        height: 50,
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: const Color.fromRGBO(146, 150, 187, 10),
          onPressed: () {
            Navigator.of(context).pushNamed('/newAccount');
          },
          child: const Text(
            "¿ERES NUEVO? CREA NUEVA CUENTA",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    });
  }
}
