import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/pages/home.dart';

final tips = [
  '¿Qué es CBT?',
  '¿Cómo cuidar mi salud mental?',
  'Tips para una mejor organización',
  '¿Cómo manejar mi enojo?',
  '10 consejos para cuidar tu salud mental',
  '¿La salud mental puede afectar en mis estudios?',
];
final tips2 = [
  '10 consejos para cuidar tu salud mental',
  '¿Cómo manejar mi enojo?',
  'tips para empezar el amor propio',
  'La procrastinación',
  '¿Cómo establecer objetivos smart?',
  '¿las afirmaciones realmente me ayudan?',
];
String text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex.";

class LearnPage extends StatefulWidget {
  final String idSend;

  LearnPage(this.idSend);
  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Quieres salir de esta sección?"),
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
        body: SingleChildScrollView(
          child: SafeArea(
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
                      Column(
                        children: [
                          H1Label("Recomendaciones para ti"),
                          CarouselSlider.builder(
                            options: CarouselOptions(
                                height: 160,
                                enableInfiniteScroll: false,
                                viewportFraction: .6,
                                disableCenter: false,
                                initialPage: 0),
                            itemCount: tips.length,
                            itemBuilder: (context, index, realIndex) {
                              final tip = tips[index];
                              return buildContainer(tip, index, context);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          H1Label("Psicología"),
                          SizedBox(
                            height: 10,
                          ),
                          Psicologia("¿Qué es el CBT?"),
                          Psicologia("¿Por qué es importante el test gad-7?"),
                          Psicologia("¿Qué mide el test PHQ-9?"),
                          H1Label("Tips y consejos"),
                          Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              for(int i = 0;i<tips2.length;i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                    height: 120,
                                    width: MediaQuery.of(context).size.width / 3.7,
                                    child: Center(
                                        child: Text(
                                      tips2[i].toString(),
                                      textAlign: TextAlign.center,
                                    ))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          isTheSameLearn: true,
          learnColorIcon: false,
          idSend: widget.idSend,
        ),
      ),
    );
  }

  Widget buildContainer(String tip, int index, BuildContext context) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Container1(widget.idSend)));
        },
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
            width: 200,
            child: Center(
                child: Text(
              tips[index].toString(),
              textAlign: TextAlign.center,
            ))),
      );
  Widget Psicologia(String texto) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
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
      child: Text(
        texto,
        style: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Container1 extends StatefulWidget {
  final String idSend;
  Container1(this.idSend);
  @override
  State<Container1> createState() => _Container1State();
}

class _Container1State extends State<Container1> {
  late Timer _timer;
  @override
  void initState() {
    _progress1 == 0;
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => setState(() {
              if (_progress1 == 1) {
                timer.cancel();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Container2(widget.idSend)));
              } else {
                _progress1 += 0.2;
              }
            }));
    super.initState();
  }

  double _progress1 = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

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
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      value: _progress1,
                    ),
                  ),
                  TitleHeader("Aprende algo nuevo"),
                  Column(
                    children: <Widget>[
                      H1Label(tips[0]),
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
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bot.png'),
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
    );
  }
}

class Container2 extends StatefulWidget {
  final String idSend;
  Container2(this.idSend);
  @override
  State<Container2> createState() => _Container2State();
}

class _Container2State extends State<Container2> {
  late Timer _timer;
  @override
  void initState() {
    _progress1 == 0;
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => setState(() {
              if (_progress1 == 1) {
                timer.cancel();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Container3(widget.idSend)));
              } else {
                _progress1 += 0.2;
              }
            }));
    super.initState();
  }

  double _progress1 = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

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
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      value: _progress1,
                    ),
                  ),
                  TitleHeader("Aprende algo nuevo"),
                  Column(
                    children: <Widget>[
                      H1Label(tips[1]),
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
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bot.png'),
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
    );
  }
}

class Container3 extends StatefulWidget {
  final String idSend;
  Container3(this.idSend);
  @override
  State<Container3> createState() => _Container3State();
}

class _Container3State extends State<Container3> {
  late Timer _timer;
  @override
  void initState() {
    _progress1 == 0;
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => setState(() {
              if (_progress1 == 1) {
                timer.cancel();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Container4(widget.idSend)));
              } else {
                _progress1 += 0.2;
              }
            }));
    super.initState();
  }

  double _progress1 = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

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
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      value: _progress1,
                    ),
                  ),
                  TitleHeader("Aprende algo nuevo"),
                  Column(
                    children: <Widget>[
                      H1Label(tips[2]),
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
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bot.png'),
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
    );
  }
}

class Container4 extends StatefulWidget {
  final String idSend;
  Container4(this.idSend);
  @override
  State<Container4> createState() => _Container4State();
}

class _Container4State extends State<Container4> {
  late Timer _timer;
  @override
  void initState() {
    _progress1 == 0;
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => setState(() {
              if (_progress1 == 1) {
                timer.cancel();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Container5(widget.idSend)));
              } else {
                _progress1 += 0.2;
              }
            }));
    super.initState();
  }

  double _progress1 = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

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
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      value: _progress1,
                    ),
                  ),
                  TitleHeader("Aprende algo nuevo"),
                  Column(
                    children: <Widget>[
                      H1Label(tips[3]),
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
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bot.png'),
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
    );
  }
}

class Container5 extends StatefulWidget {
  final String idSend;
  Container5(this.idSend);
  @override
  State<Container5> createState() => _Container5State();
}

class _Container5State extends State<Container5> {
  late Timer _timer;
  @override
  void initState() {
    _progress1 == 0;
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => setState(() {
              if (_progress1 == 1) {
                timer.cancel();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Container6(widget.idSend)));
              } else {
                _progress1 += 0.2;
              }
            }));
    super.initState();
  }

  double _progress1 = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

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
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      value: _progress1,
                    ),
                  ),
                  TitleHeader("Aprende algo nuevo"),
                  Column(
                    children: <Widget>[
                      H1Label(tips[4]),
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
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bot.png'),
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
    );
  }
}

class Container6 extends StatefulWidget {
  final String idSend;
  Container6(this.idSend);
  @override
  State<Container6> createState() => _Container6State();
}

class _Container6State extends State<Container6> {
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
                  Column(
                    children: <Widget>[
                      H1Label(tips[5]),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LearnPage(widget.idSend)));
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
    );
  }
}
