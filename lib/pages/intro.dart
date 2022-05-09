import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp2022_front/main.dart';

class IntroPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Material(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/imagen1.jpg'),
                  ),
                ),
                child: Stack(),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35,vertical: 35),
            child: Text("Mejora en los estudios, empezando el primer cambio en ti",style:TextStyle(color: Color.fromRGBO(67, 58, 108, 10),fontSize: 29.0,fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
            child: MakeTheFirstMove(context),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: IAlreadyHaveAnAccount()
          )
        ],
      ),
    );

  }
}

@override
Widget MakeTheFirstMove(BuildContext context) {
  return Container(

    width: 280,
    height: 70,
    child: RaisedButton(

      color: Color.fromRGBO(104, 174, 174, 10),
      onPressed: ()
      {
        Navigator.of(context).pushNamed('/home');
      },
      child: const Text("Dar el primer paso", style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
    ),
  );
}

Widget IAlreadyHaveAnAccount(){
  //cambiar a boton
  return Container(
    alignment: Alignment.center,
    child: FlatButton(
        onPressed: (){},
        child: Text("YA TENGO UNA CUENTA",style:TextStyle(color: Color.fromRGBO(104, 110, 174, 10),fontSize: 20.0,fontWeight: FontWeight.bold))
    ),
  );
}