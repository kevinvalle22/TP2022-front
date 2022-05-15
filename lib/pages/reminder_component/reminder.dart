import 'package:flutter/material.dart';

void main() => runApp(ReminderPage());

class ReminderPage extends StatelessWidget {
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
              onPressed: () {},
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

class Cuerpo extends StatelessWidget {
  const Cuerpo({Key? key}) : super(key: key);

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

class Components extends StatelessWidget {
  const Components({Key? key}) : super(key: key);

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

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Text("Recordatorios",
                style: TextStyle(
                    color: Color.fromRGBO(146, 150, 187, 10),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)))
      ],
    );
  }
}
