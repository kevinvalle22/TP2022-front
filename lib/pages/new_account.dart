import 'package:flutter/material.dart';

class NewAccountPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Form(
          key: formKey,
          child: Cuerpo(context),
        ),
        
      ),
    );
  }
}

Widget Cuerpo(BuildContext context) {
  return Container(
    child: SingleChildScrollView(
      child: Column(
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
            top: 70,
            width: 420,
            height: 1000,
            child: Components(context),
          ),
          
        ]),
        
      ],
      ),

    ),
  );
}

Widget Components(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          child: Name(),
        ),
        Container(
          child: UserField(),
        ),
        Container(
          child: EmailField(),
        ),
        Container(
          child: PhoneField(),
        ),
        Container(
          child: PasswordField(),
        ),
        Container(
          child: UniversityField(),
        ),
        Container(
          child: ProvinceField(),
        ),
        Container(
          child: DistrictField(),
        ),
        Container(
          child: CreateAccount(context),
        ),
        const Divider(
          color: Color.fromRGBO(146, 150, 187, 10),
          indent: 100,
          endIndent: 100,
          thickness: 1,
        ),
        Container(
          child: ComeBack(context),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    ),
  );
}

Widget Name() {
  return const Text("Crear Nueva Cuenta",
      style: TextStyle(
          color: Color.fromRGBO(67, 58, 108, 10),
          fontSize: 35.0,
          fontWeight: FontWeight.bold));
}

Widget UserField() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: TextField(
      decoration: InputDecoration(
          fillColor: const Color.fromRGBO(232, 227, 238, 10),
          filled: true,
          focusColor: const Color.fromRGBO(146, 150, 187, 10),
          labelStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          hintStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          labelText: "Usuario",
          hintText: "usuario",
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

Widget EmailField() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: TextField(
      decoration: InputDecoration(
          fillColor: const Color.fromRGBO(232, 227, 238, 10),
          filled: true,
          focusColor: const Color.fromRGBO(146, 150, 187, 10),
          labelStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          hintStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          labelText: "Email",
          hintText: "usuario@mail.com",
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

Widget PhoneField() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          fillColor: const Color.fromRGBO(232, 227, 238, 10),
          filled: true,
          focusColor: const Color.fromRGBO(146, 150, 187, 10),
          labelStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          hintStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          labelText: "Número de celular",
          hintText: "(+51) 999-999-999",
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
          focusColor: const Color.fromRGBO(146, 150, 187, 10),
          labelStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          hintStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          labelText: "Contraseña",
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

Widget UniversityField() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: TextField(
      decoration: InputDecoration(
          fillColor: const Color.fromRGBO(232, 227, 238, 10),
          filled: true,
          focusColor: const Color.fromRGBO(146, 150, 187, 10),
          labelStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          hintStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          labelText: "Universidad",
          hintText: "Universidad",
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

Widget ProvinceField() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: TextField(
      decoration: InputDecoration(
          fillColor: const Color.fromRGBO(232, 227, 238, 10),
          filled: true,
          focusColor: const Color.fromRGBO(146, 150, 187, 10),
          labelStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          hintStyle: const TextStyle(color: Color.fromRGBO(146, 150, 187, 10)),
          labelText: "Provincia",
          hintText: "provincia",
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

Widget DistrictField() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: TextField(
      decoration: InputDecoration(
          fillColor: const Color.fromRGBO(232, 227, 238, 10),
          filled: true,
          focusColor: const Color.fromRGBO(146, 150, 187, 10),
          labelStyle: const TextStyle(color:Color.fromRGBO(146, 150, 187, 10)),
          hintStyle: const TextStyle(color:Color.fromRGBO(146, 150, 187, 10)),
          labelText: "Distrito",
          hintText: "distrito",
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

Widget CreateAccount(BuildContext context) {
  return Container(
    width: 450,
    height: 70,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    child: RaisedButton(
      color: Color.fromRGBO(104, 174, 174, 6),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("Crear Cuenta",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

@override
Widget ComeBack(BuildContext context) {
  return Container(
    width: 450,
    height: 70,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: const Color.fromRGBO(146, 150, 187, 10),
      onPressed: () {
        Navigator.of(context).pushNamed('/home');
      },
      child: const Text("¿YA TIENES CUENTA? INICIA AHORA",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
