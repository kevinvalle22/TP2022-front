import 'package:flutter/material.dart';

import 'intro.dart';
import 'new_account.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GestureDetector(
        //el teclado no sobreponga los datos del ListView
        onTap: (){
          final FocusScopeNode focus = FocusScope.of(context);
          if(!focus.hasPrimaryFocus && focus.hasFocus){
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: ListView(
          children: [Components()],
        ),
      ),
    );
  }

}

Widget Components(){
  return Center(
    //SingleChildScrollViewl para que no aparezca el error de overflowed by 40 pixel
    child: SingleChildScrollView(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: <Widget>[
          Name(),
          UserField(),
          PasswordField(),
          const SizedBox(height: 40),
          BtnForgotPassword(),
          const SizedBox(height: 15),
          SignIn(),
          const SizedBox(height: 30),

          const SizedBox(height: 20),
          NewAccount()
        ],
      ),
    ),
  );
}
Widget Name(){

  return Container(
      margin: EdgeInsets.all(80),
      alignment: Alignment.topLeft,
      child: const Text("Iniciar Sesión",style:TextStyle(color: Color.fromRGBO(67, 58, 108, 10),fontSize: 35.0,fontWeight: FontWeight.bold)
      )
  );
}

Widget UserField(){
  return Container(
    padding: EdgeInsets.all(30.0),
    child: TextField(
      decoration: InputDecoration(
          labelText: "Usuario",
          hintText: "Su usuario",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget PasswordField(){
  return Container(
    padding: EdgeInsets.all(30.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Contraseña",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color: Color.fromRGBO(232, 227, 238, 10)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3,color:Colors.red),
            borderRadius: BorderRadius.circular(15),
          )
      ),
    ),
  );
}

Widget BtnForgotPassword(){
  //cambiar a boton
  return Container(
    alignment: Alignment.centerRight,
    child: FlatButton(
        onPressed: (){},
        child: Text("¿Olvidaste tu contraseña?",style:TextStyle(color: Color.fromRGBO(67, 58, 108, 10),fontSize: 15.0))
    ),
  );
}

Widget SignIn(){
  return Builder(
      builder: (context) {
        return Container(
          width: 320,
          height: 50,
          child: RaisedButton(
            color: Color.fromRGBO(104, 174, 174, 6),
            onPressed: ()
            {
              Navigator.of(context).pushNamed('/intro');
            },
            child: Text("INICIAR SESIÓN",style: TextStyle(fontSize: 14,color: Colors.white),),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
          ),
        );
      }
  );
}

Widget NewAccount(){

  return Builder(
      builder: (context) {
        return Container(

          width: 320,
          height: 50,
          child: RaisedButton(

            color: Color.fromRGBO(146, 150, 187, 10),
            onPressed: ()
            {
              Navigator.of(context).pushNamed('/newAccount');
            },
            child: const Text("¿ERES NUEVO? CREA NUEVA CUENTA",style: TextStyle(fontSize: 14,color: Colors.white),),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
          ),
        );
      }
  );
}
