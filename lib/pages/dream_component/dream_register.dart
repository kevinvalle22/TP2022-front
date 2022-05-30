import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/Components/screen_form.dart';

class DreamRecordsPage extends StatefulWidget {
  @override
  State<DreamRecordsPage> createState() => _DreamRecordsPageState();
}

class _DreamRecordsPageState extends State<DreamRecordsPage> {

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
                    CalendarWidget(),
                    Row(
                      children: [
                        H1Label("Horas de Sueño"),
                        Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(182, 220, 220, 10),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                _bottomSheet(context);
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    ContainerLabelDreams()
                    
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
  _bottomSheet(context){
    showModalBottomSheet(
      isScrollControlled: true,
      
      context: context, 
      builder: (BuildContext c){
        
        return ScreenFormExercises("Registro de Horas","Escribir descripción ...","REGISTRAR HORAS");
      }
      );
  }
}