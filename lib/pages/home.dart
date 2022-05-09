

import 'package:flutter/material.dart';
import 'package:tp2022_front/pages/test.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Components(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_outlined),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

Widget Components() {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/originals/1b/da/2f/1bda2fa61500b9e918cec3061e5507ca.jpg'),
            fit: BoxFit.cover)),
    child: ListView(
      children: [
        Container(
          child: Footer(),
        ),
        Container(
          child: Body(),
        )
      ],
    ),
  );
}

Widget Footer() {
  return Container(
      child: Row(
    children: [
      Container(padding: EdgeInsets.all(40.0), child: Name()),
      Container(
        padding: EdgeInsets.all(20.0),
        child: PhoneIcon(),
      )
    ],
  ));
}

Widget Name() {
  return const Text("Hola User",
      style: TextStyle(
          color: Color.fromRGBO(67, 58, 108, 10),
          fontSize: 35.0,
          fontWeight: FontWeight.bold));
}

Widget PhoneIcon() {
  return RawMaterialButton(
    onPressed: () {},
    child: Icon(
      Icons.phone,
      color: Colors.red,
      size: 30.0,
    ),
    shape: CircleBorder(),
    elevation: 2.0,
    fillColor: Colors.white,
    padding: EdgeInsets.all(15.0),
  );
}

Widget Body() {
  return Builder(builder: (context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Text("¿Cómo te Sientes hoy?",
                style: TextStyle(
                    color: Color.fromRGBO(146, 150, 187, 10),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 300,
            height: 60,
            child: RaisedButton(
              color: Color.fromRGBO(231, 190, 129, 10),
              onPressed: () {
                Navigator.of(context).pushNamed('/chatbot');
              },
              child: const Text("¿TE GUSTARIA TOMAR UN TEST?",
                  style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Container(
            child: Screens(2, 45, 70),
          ),
          Container(
            child: Screens(2, 45, 70),
          ),
          SizedBox(height: 25),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Text(
              "Usuario:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Screens(3, 45, 45),
          )
        ],
      ),
    );
  });
}
