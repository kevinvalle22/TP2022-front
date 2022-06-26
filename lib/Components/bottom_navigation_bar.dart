import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tp2022_front/pages/chat_component/chatbot.dart';
import 'package:tp2022_front/pages/graph_component/graph.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/pages/learn_component/learn.dart';
import 'package:tp2022_front/pages/profile.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

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
      color: Color.fromRGBO(254, 246, 238, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined),
            onPressed: () {
              widget.isTheSameHome
                  ? null
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(widget.idSend)));
            },
            color: widget.homeColorIcon ? null : Colors.lightGreenAccent,
            splashColor: Color.fromRGBO(67, 58, 108, 10),
          ),
          IconButton(
            icon: Icon(Icons.crop_square_sharp),
            onPressed: () {
              widget.isTheSameLearn
                  ? null
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LearnPage(widget.idSend)));
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
              icon: Image.asset('assets/icons/bot bar.png'),
              constraints: BoxConstraints(
                  minWidth: 100, minHeight: 52.5, maxWidth: double.infinity),
              onPressed: () {
                dynamic user = {
                  'userId': widget
                      .idSend, //Replace it with the userId of the logged in user
                  'password':
                      'secret' //Put password here if user has password, ignore otherwise
                };
                dynamic conversationObject = {
                  'appId':
                      '2b582f32821ad1179e5ace33665091779', // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                  'kmUser': jsonEncode(user)
                };

                KommunicateFlutterPlugin.buildConversation(conversationObject)
                    .then((clientConversationId) {
                  print("Conversation builder success : " +
                      clientConversationId.toString());
                }).catchError((error) {
                  print("Conversation builder error : " + error.toString());
                });

                /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatBotPage(widget.idSend))); */
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
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GraphPage(widget.idSend)));
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
                widget.isTheSameProfile
                    ? null
                    : Navigator.push(
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
