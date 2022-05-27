import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    this.isTheSameHome = false,
    this.homeColorIcon = true,
    this.isTheSameLearn = false,
    this.learnColorIcon = true,
    this.isTheSameBot = false,
    this.botColorIcon = true,
    this.isTheSameGraph = false,
    this.graphColorIcon = true,
    this.isTheSameProfile=false,
    this.profileColorIcon=true,
  });
  //estos bools son para que cuando se encuentre directamente en la pantalla misma, no navegue a la misma pantalla. Haciendo el efecto de ir una y otra vez. Por ejemplo, si me encuentro en el screen de home, cuando le doy tap al icon de home, se inhabilita. Lo mismo para los demás y evito que se sobreescriba
  bool isTheSameHome;
  bool homeColorIcon;

  bool isTheSameLearn;
  bool learnColorIcon;

  bool isTheSameBot;
  bool botColorIcon;

  bool isTheSameGraph;
  bool graphColorIcon;

  bool isTheSameProfile;
  bool profileColorIcon;

  var routes = ['/home', '/learn', '/chatbot', '/graph', '/profile'];
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
            color: homeColorIcon ? null : Colors.lightGreenAccent,
            splashColor: Color.fromRGBO(67, 58, 108, 10),
          ),
          IconButton(
            icon: Icon(Icons.crop_square_sharp),
            onPressed: () {
              isTheSameLearn
                  ? null
                  : Navigator.of(context).pushNamed(routes[1]);
            },
            color: learnColorIcon ? null : Colors.greenAccent,
            splashColor: Color.fromRGBO(67, 58, 108, 10),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: botColorIcon ? null : Colors.lightGreenAccent),
            child: IconButton(
              highlightColor: botColorIcon ? null : Colors.lightGreenAccent,
              icon: Image.asset('assets/bot.png'),
              onPressed: () {
                isTheSameBot
                    ? null
                    : Navigator.of(context).pushNamed(routes[2]);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: graphColorIcon ? null : Colors.lightGreenAccent),
            child: IconButton(
              icon: Image.asset(
                'assets/ios.png',
              ),
              onPressed: () {
                isTheSameGraph
                    ? null
                    : Navigator.of(context).pushNamed(routes[3]);
              },
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: profileColorIcon ? null : Colors.lightGreenAccent),
            child: IconButton(
              icon: Image.asset('assets/usuario.png'),
              onPressed: () {
                isTheSameProfile?null:Navigator.of(context).pushNamed(routes[4]);
              },
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
          ),
        ],
      ),
    );
  }
}
