// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ChatBotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/7.jpg'),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Column(
                    children: [
                      Text("ChatBot",
                          style: TextStyle(
                              color: Color.fromRGBO(67, 58, 108, 10),
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold)),
                      Divider(
                        color: Color.fromRGBO(146, 150, 187, 10),
                        thickness: 1,
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                            )
                                          ]),
                                      child: CircleAvatar(
                                          radius: 15,
                                          backgroundImage:
                                              AssetImage('assets/bot.png')),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8),
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
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
                                      child: Text(
                                          "¡Hola! Soy tu asistente virtual que te ayudará a realizar los test de ansiedad y tristeza, ¿Con cuál te gustaría empezar?"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8),
                                        padding: EdgeInsets.all(10),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                              )
                                            ]),
                                        child: Text("Test de Ansiedad"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          )
                                        ]),
                                    child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage:
                                            AssetImage('assets/perfil.png')),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                            )
                                          ]),
                                      child: CircleAvatar(
                                          radius: 15,
                                          backgroundImage:
                                              AssetImage('assets/bot.png')),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8),
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
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
                                      child: Text(
                                          "¡Genial! Empezaré con las preguntas de poco a poco, ¿Vale?"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 70,
                      //color: Colors.white,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 242, 250, 10),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: "Escribir aquí..."),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color.fromRGBO(147, 150, 186, 10)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
              bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined),
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
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
                onPressed: null,
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
