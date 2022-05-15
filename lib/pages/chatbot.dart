
import 'package:flutter/material.dart';
import 'package:tp2022_front/pages/test.dart';

class ChatBotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Components(context),
    );
  }
}


Widget Components(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/originals/1b/da/2f/1bda2fa61500b9e918cec3061e5507ca.jpg'),
            fit: BoxFit.cover)),
    child: ListView(
      padding: EdgeInsets.symmetric(vertical: 40),
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: Name(),
        ),
        Container(
          child: Chats(),
        ),
        SizedBox(height: 250),
        Container(
          padding: EdgeInsets.all(30.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: "input",
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3,color:Colors.red),
                  borderRadius: BorderRadius.circular(15),
                )
            ),
          ),
        )
      ],
    ),
  );
}

Widget Name() {
  return IntrinsicWidth(
    child: Column(
      children: [
        const Text("Chatbot",
            style: TextStyle(
                color: Color.fromRGBO(67, 58, 108, 10),
                fontSize: 35.0,
                fontWeight: FontWeight.bold)),
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
      ],
    ),
  );
}

Widget Chats(){
  return Builder(
    builder: (context) {
      return Container(
        child: Expanded(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: Screen(0,320),
                    )
                  ],
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Container(
                      child: Screen(1,180),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {},
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {},
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: Screen(2,320),
                    )
                  ],
                ),
              ),
              //input


            ],
          ),
        ),
      );
    }
  );
}

