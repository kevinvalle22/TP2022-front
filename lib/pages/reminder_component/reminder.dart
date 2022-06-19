import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar/calendar_remainder.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/pages/test.dart';

//void main() => runApp(ReminderPage());

class ReminderPage extends StatefulWidget {
  final String idSend;

  ReminderPage(this.idSend);
  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Deseas regresar al menú principal?"),
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
                Container(child: BackgroundImage('assets/7.jpg')),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      TitleHeader("Recordatorio"),
                      CalendarRemainer(widget.idSend),

                      //ContainerLabelDreams()
                    ],
                  ),
                ),
              ],
            )),
          )),
          bottomNavigationBar: BottomNavigation(idSend: widget.idSend)),
    );
  }
}
