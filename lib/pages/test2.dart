import 'package:flutter/material.dart';

void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Cuerpo(),

    );
  }
}

class Cuerpo extends StatefulWidget {
  Cuerpo({Key? key}) : super(key: key);

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/7.jpg'),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 500,
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        height: 500,
                        color: Colors.red,
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(hintText: "sss"),
                            ),
                            TextField(
                              decoration: InputDecoration(hintText: "sss"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
