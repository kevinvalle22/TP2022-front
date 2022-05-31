// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tp2022_front/ControllerEndpoints/endpoints.dart';
import 'package:tp2022_front/pages/chat_component/chatbot.dart';
import 'package:tp2022_front/pages/diary_components/diary.dart';
import 'package:tp2022_front/pages/dream_component/dream_register.dart';
import 'package:tp2022_front/pages/exercises_components/exercises.dart';
import 'package:tp2022_front/pages/exercises_components/record_exercises.dart';
import 'package:tp2022_front/pages/graph_component/graph.dart';
import 'package:tp2022_front/pages/help_component/help.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/pages/intro.dart';
import 'package:tp2022_front/pages/learn_component/learn.dart';
import 'package:tp2022_front/pages/loading.dart';
import 'package:tp2022_front/pages/new_account.dart';
import 'package:tp2022_front/pages/objective_components/new_objetctive.dart';
import 'package:tp2022_front/pages/objective_components/objective.dart';
import 'package:tp2022_front/pages/positive_reinforcement_component/assertion_settings.dart';
import 'package:tp2022_front/pages/positive_reinforcement_component/positive_reinforcement.dart';
import 'package:tp2022_front/pages/profile.dart';
import 'package:tp2022_front/pages/reminder_component/calendar.dart';
import 'package:tp2022_front/pages/reminder_component/reminder.dart';
import 'package:tp2022_front/pages/sign_in.dart';

void main() {
  DataBaseHelper dataBaseHelper = new DataBaseHelper();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/newAccount': (context) => NewAccountPage(),
        '/intro': (context) => IntroPage(),
        '/home': (context) => HomePage(),
        '/chatbot': (context) => ChatBotPage(),
        '/help': (context) => HelpPage(),
        '/positive': (context) => PositveReinforcementPage(),
        '/reminder': (context) => ReminderPage(),
        '/calendar': (context) => CalendarPage(),
        '/loading': (context) => LoadingPage(),
        '/objective': (context) => ObjectivePage(),
        '/newObjective': (context) => NewObjetivePage(),
        '/diary': (context) => DiaryPage(),
        '/exercises': (context) => ExercisesPage(),
        '/learn': (context) => LearnPage(),
        '/record_exercises': (context) => RecordExercisesPage(),
        '/assertion_settings': (context) => AssertionSettings(),
        '/graph': (context) => GraphPage(),
        '/profile': (context) => ProfilePage(),
        '/record_dream': (context) => DreamRecordsPage(),
      },
      initialRoute: '/loading',
    );
  }
}
