import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/Components/calendar/calendar_exercises.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/Components/screen_form.dart';

import '../home.dart';

class RecordExercisesPage extends StatefulWidget {
  final String idSend;

  RecordExercisesPage(this.idSend);
  @override
  State<RecordExercisesPage> createState() => _RecordExercisesPageState();
}

class _RecordExercisesPageState extends State<RecordExercisesPage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Quieres salir al menú principal?"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No")),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(widget.idSend))),
                  child: Text("Si")),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                child: Stack(
              children: <Widget>[
                Container(child: BackgroundImage('assets/fondos/ejercicios fisicos.png')),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TitleHeader("Ejercicios físicos"),
                      CalendarExercises(widget.idSend),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
      ),
    );
  }
}
