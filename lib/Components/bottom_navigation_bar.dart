import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {

  BottomNavigation({
    this.isTheSameHome=false,
    this.isTheSameLearn=false,
    this.isTheSameBot=false,
  });
  //estos bools son para que cuando se encuentre directamente en la pantalla misma, no navegue a la misma pantalla. Haciendo el efecto de ir una y otra vez. Por ejemplo, si me encuentro en el screen de home, cuando le doy tap al icon de home, se inhabilita. Lo mismo para los demás y evito que se sobreescriba
  bool isTheSameHome;
  bool isTheSameLearn;
  bool isTheSameBot;
  var routes = [
    '/home',
    '/learn',
    '/chatbot'
  ];
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                isTheSameHome ? null : Navigator.of(context).pushNamed(routes[0]);  
              },
              color: Colors.greenAccent,
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Icon(Icons.crop_square_sharp),
              onPressed: () {
                isTheSameLearn? null : Navigator.of(context).pushNamed(routes[1]);
              },
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Image.asset('assets/bot.png'),
              onPressed: (){
                isTheSameBot ? null : Navigator.of(context).pushNamed(routes[2]);
              },
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Image.asset('assets/ios.png'),
              onPressed: () {},
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Image.asset('assets/usuario.png'),
              onPressed: () {},
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
          ],
        ),
      );
  }
}