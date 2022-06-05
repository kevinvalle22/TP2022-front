import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/Components/screen_form.dart';

class DiaryPage extends StatefulWidget {
  final String idSend;

  DiaryPage(this.idSend);
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Stack(
            children: <Widget>[
              Container(child: BackgroundImage('assets/5.jpg')),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TitleHeader("Pensamientos"),
                    CalendarWidget(widget.idSend),
                    Row(
                      children: [
                        H1Label("Mi lista de pensamientos"),
                        Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(182, 220, 220, 10),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _bottomSheet(context);
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    ContainerLabel(),
                    ContainerLabel(),
                    ContainerLabel(),
                    ContainerLabel(),
                    ContainerLabel(),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
    );
  }

  _bottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext c) {
          return ScreenFormDiary("Nuevo Pensamiento",
              "Escribir nuevo pensamiento ...", "Registrar Ejercicio");
        });
  }
}
