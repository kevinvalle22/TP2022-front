import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/pages/chatbot.dart';
import 'package:tp2022_front/pages/help_component/help.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/pages/intro.dart';
import 'package:tp2022_front/pages/new_account.dart';
import 'package:tp2022_front/pages/positive_reinforcement_component/positive_reinforcement.dart';
import 'package:tp2022_front/pages/reminder_component/reminder.dart';
import 'package:tp2022_front/pages/sign_in.dart';
import 'package:tp2022_front/pages/test.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/newAccount': (context) => NewAccountPage(),
        '/intro':(context)=>IntroPage(),
        '/home': (context) => HomePage(),
        '/chatbot': (context) =>ChatBotPage(),
        '/help': (context) => HelpPage(),
        '/positive': (context)=>PositveReinforcementPage(),
        '/reminder':  (context) => ReminderPage()
      },
      initialRoute: '/intro',
    );
  }
  
}

