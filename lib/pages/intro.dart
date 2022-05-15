import 'package:dots_indicator/dots_indicator.dart';
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
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/4.jpg'),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                height: 435,
                width: 420,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/Imagen1.png'),
                    ),
                  ),
                ),
              ),
              Positioned(
                height: 400,
                width: 420,
                top: 420,
                child: Rest(context)
                ),
              // ignore: avoid_unnecessary_containers
              Positioned(
                // para mover como si fuera slice
                top: 415,
                height: 65,
                width: 65,
                child: DotsIndicator(
                  dotsCount: 3,
                ),
              ),
            ],
            
          ),
        ],
 
      ),
    );

  }
}

// ignore: non_constant_identifier_names
Widget Rest(BuildContext context){
  return Column(
    children:<Widget> [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 35,vertical: 45),
        child: const Text("Mejora en los estudios, empezando el primer cambio en ti",style:TextStyle(color: Color.fromRGBO(67, 58, 108, 10),fontSize: 28.0,fontWeight: FontWeight.bold)),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: MakeTheFirstMove(context),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: IAlreadyHaveAnAccount()
      )
    ],
  );
}

Widget MakeTheFirstMove(BuildContext context) {
  return Container(

    width: 250,
    height: 70,
    child: RaisedButton(

      color: Color.fromRGBO(104, 174, 174, 10),
      onPressed: ()
      {
        Navigator.of(context).pushNamed('/login');
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
        child: Text("YA TENGO UNA CUENTA",style:TextStyle(color: Color.fromRGBO(104, 110, 174, 10),fontSize: 16.0,fontWeight: FontWeight.bold))
    ),
  );
}
