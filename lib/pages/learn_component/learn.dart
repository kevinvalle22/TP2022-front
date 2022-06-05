import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';

class LearnPage extends StatefulWidget {
  final String idSend;

  LearnPage(this.idSend);
  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  List<String> tips = [
    '¿Qué es CBT?',
    '¿Cómo cuidar mi salud mental?',
    'Tips para una mejor organización',
    '¿Cómo manejar mi enojo?',
    '10 consejos para cuidar tu salud mental',
    '¿La salud mental puede afectar en mis estudios?',
  ];
  String text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex.";
  bool _boxes = true;
  bool a = true;
  bool b = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: <Widget>[
            Container(
              child: BackgroundImage('assets/2.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TitleHeader("Aprende algo nuevo"),
                  if (_boxes == true)
                    Column(
                      children: [
                        H1Label("Definiciones, tips y consejos"),
                        Wrap(
                          children: <Widget>[
                            for (int i = 0; i < tips.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (i == 0) {
                                        _boxes = false;
                                        a = true;
                                        //_string0 = true;
                                      } else if (i == 1) {
                                        _boxes = false;
                                        b = true;
                                      } else if (i == 2) {
                                        _boxes = false;
                                      } else if (i == 3) {
                                        _boxes = false;
                                      } else if (i == 4) {
                                        _boxes = false;
                                      } else if (i == 5) {
                                        _boxes = false;
                                      }
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(232, 227, 238, 10),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                            )
                                          ]),
                                      width: 150,
                                      height: 160,
                                      child: Center(
                                          child: Text(
                                        tips[i].toString(),
                                        textAlign: TextAlign.center,
                                      ))),
                                ),
                              )
                          ],
                        )
                      ],
                    )
                  else
                    Column(
                      children: <Widget>[
                        if (a == true) ...[
                          H1Label(tips[2]),
                        ] else if (b == true) ...[
                          H1Label(tips[1]),
                        ],
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(232, 227, 238, 10),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(text),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _boxes = true;
                            });
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/bot.png'),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: BottomNavigation(
          isTheSameLearn: true, learnColorIcon: false, idSend: widget.idSend),
    );
  }
}
