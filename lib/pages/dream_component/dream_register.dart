import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/Components/calendar/calendar_dreams.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/Components/screen_form.dart';

class DreamRecordsPage extends StatefulWidget {
  final String idSend;

  DreamRecordsPage(this.idSend);
  @override
  State<DreamRecordsPage> createState() => _DreamRecordsPageState();
}

class _DreamRecordsPageState extends State<DreamRecordsPage> {
  String string = "03 horas y 07 minutos";
  // convertir a numero tipo double hh.mm
  double convertToDouble(String string) {
    List<String> list = string.split(" ");
    double hours = double.parse(list[0]);
    double minutes = double.parse(list[3]);
    double total = hours + (minutes / 100);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    TitleHeader("Registro de sueño"),
                    CalendarDreams(widget.idSend),
                    ContainerLabelDreams(widget.idSend)
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        idSend: widget.idSend,
      ),
    );
  }

  _bottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext c) {
          return ScreenFormExercises(
              "Registro de Horas",
              "Escribir una Fecha ...",
              "REGISTRAR HORAS",
              widget.idSend,
              "dream");
        });
  }
}
