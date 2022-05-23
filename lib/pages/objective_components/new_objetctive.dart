import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';

import 'objective.dart';

void main() => runApp(NewObjetivePage());

class NewObjetivePage extends StatefulWidget {
  @override
  State<NewObjetivePage> createState() => _NewObjetivePageState();
}

class _NewObjetivePageState extends State<NewObjetivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                child: BackgroundImage('assets/7.jpg'),
              ),
              Column(
                children: <Widget>[
                  TitleHeader("Nuevo Objetivo"),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            H1Label("Objetivo"),
                            InputLabel("Escribir objetivo ..."),
                            H1Label("Tipo de Objetivo"),
                            TagsLabelObjective(),
                            H1Label("Categoría"),
                            for (int i = 0; i < 3; i++)
                              Container(
                                child: TagsCategories(),
                              ),
                            H1Label("Plan de Acción"),
                            for (int i = 0; i < 3; i++)
                              Container(
                                child: InputLabel("¿Qué harás para cumplirlo?"),
                              ),
                            ButtomLabel("CREAR OBJETIVO")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}


