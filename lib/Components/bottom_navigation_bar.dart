import 'package:flutter/material.dart';
import 'package:tp2022_front/pages/profile.dart';

class BottomNavigation extends StatefulWidget {
  final String idSend;
  BottomNavigation(
      {this.isTheSameHome = false,
      this.homeColorIcon = true,
      this.isTheSameLearn = false,
      this.learnColorIcon = true,
      this.isTheSameBot = false,
      this.botColorIcon = true,
      this.isTheSameGraph = false,
      this.graphColorIcon = true,
      this.isTheSameProfile = false,
      this.profileColorIcon = true,
      required this.idSend});

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

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
              widget.isTheSameHome
                  ? null
                  : Navigator.of(context).pushNamed(routes[0]);
            },
            color: widget.homeColorIcon ? null : Colors.lightGreenAccent,
            splashColor: Color.fromRGBO(67, 58, 108, 10),
          ),
          IconButton(
            icon: Icon(Icons.crop_square_sharp),
            onPressed: () {
              widget.isTheSameLearn
                  ? null
                  : Navigator.of(context).pushNamed(routes[1]);
            },
            color: widget.learnColorIcon ? null : Colors.greenAccent,
            splashColor: Color.fromRGBO(67, 58, 108, 10),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.botColorIcon ? null : Colors.lightGreenAccent),
            child: IconButton(
              highlightColor:
                  widget.botColorIcon ? null : Colors.lightGreenAccent,
              icon: Image.asset('assets/bot.png'),
              onPressed: () {
                widget.isTheSameBot
                    ? null
                    : Navigator.of(context).pushNamed(routes[2]);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.graphColorIcon ? null : Colors.lightGreenAccent),
            child: IconButton(
              icon: Image.asset(
                'assets/ios.png',
              ),
              onPressed: () {
                widget.isTheSameGraph
                    ? null
                    : Navigator.of(context).pushNamed(routes[3]);
              },
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:
                    widget.profileColorIcon ? null : Colors.lightGreenAccent),
            child: IconButton(
              icon: Image.asset('assets/usuario.png'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(widget.idSend)));
              },
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
          ),
        ],
      ),
    );
  }
}
