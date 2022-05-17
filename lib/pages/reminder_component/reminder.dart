import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2022_front/pages/test.dart';

void main() => runApp(ReminderPage());

class ReminderPage extends StatefulWidget {
  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Cuerpo()),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.greenAccent,
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Icon(Icons.crop_square_sharp),
              onPressed: () {},
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Image.asset('assets/bot.png'),
              onPressed: () {
                Navigator.of(context).pushNamed('/chatbot');
              },
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Image.asset('assets/ios.png'),
              onPressed: () {},
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
            IconButton(
              icon: Image.asset('assets/usuario.png'),
              onPressed: () {},
              splashColor: Color.fromRGBO(67, 58, 108, 10),
            ),
          ],
        ),
      ),
    );
  }
}

class Cuerpo extends StatefulWidget {
  const Cuerpo({Key? key}) : super(key: key);

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/7.jpg'),
                ),
              ),
            ),
            Positioned(
              top: 50,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 50,
              child: Components(),
            ),
          ],
        )
      ],
    );
  }
}

class Components extends StatefulWidget {
  const Components({Key? key}) : super(key: key);

  @override
  State<Components> createState() => _ComponentsState();
}

class _ComponentsState extends State<Components> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Header(),
          ),
          Container(
            child: Body(),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Name(),
    );
  }

  Widget Name() {
    return IntrinsicWidth(
      child: Column(
        children: const [
          Text("Recordatorio",
              style: TextStyle(
                  color: Color.fromRGBO(67, 58, 108, 10),
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            width: 410,
            child: Divider(
              color: Color.fromRGBO(146, 150, 187, 10),
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late bool _switchValue = true;
  late bool _switchValue2 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Text("Recordatorios",
                style: TextStyle(
                    color: Color.fromRGBO(146, 150, 187, 10),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: RemindersChart(context),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: RemindersChart(context),
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Text("Categorías",
                style: TextStyle(
                    color: Color.fromRGBO(146, 150, 187, 10),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold))),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/calendar');
                },
                child: Container(
                  child: ScreenCategories(0, 115, 110),
                ),
              ),
              //
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/calendar');
                },
                child: Container(
                  child: ScreenCategories(1, 115, 110),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/calendar');
                },
                child: Container(
                  child: ScreenCategories(2, 115, 110),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/calendar');
                },
                child: Container(
                  child: ScreenCategories(3, 115, 110),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/calendar');
                },
                child: Container(
                  child: ScreenCategories(4, 115, 110),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/calendar');
                },
                child: Container(
                  child: ScreenCategories(5, 115, 110),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget RemindersChart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
          ],
          color: Color.fromRGBO(226, 238, 239, 10),
          borderRadius: BorderRadius.circular(9.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tomar Agua.",
                  style: TextStyle(fontSize: 18),
                ),
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: myBoxDecoration(),
                          child: Text("L",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      // ignore: prefer_const_constructors
                      Text(
                        "M",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: myBoxDecoration(),
                          child: Text("M",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      Text(
                        "J",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: myBoxDecoration(),
                          child: Text("V",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                      Text(
                        "S",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: myBoxDecoration(),
                          child: Text("D",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(8.0),
                  decoration: timeBoxDecoration(),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "05:15 AM",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Color.fromRGBO(107, 174, 174, 10), shape: BoxShape.circle);
  }

  BoxDecoration timeBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(107, 174, 174, 10),
      borderRadius: BorderRadius.circular(25),
    );
  }
}
