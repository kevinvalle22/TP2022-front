import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/models/Thoughts.dart';
import 'package:tp2022_front/pages/diary_components/diary.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

class ThoughtsMod extends StatefulWidget {
  final String idSend;

  ThoughtsMod(this.idSend);

  @override
  State<ThoughtsMod> createState() => _ThoughtsModState();
}

class _ThoughtsModState extends State<ThoughtsMod> {
  final TextEditingController message = TextEditingController();
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String selectedDayString =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<dynamic> thoughtList = [];
  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    final password = await UserSecureStorage.getPassword() ?? '';
    final token = await UserSecureStorage.getToken() ?? '';
    final userId = await UserSecureStorage.getUserId() ?? '';

    thoughtList =
        await dataBaseHelper.getThoughts(widget.idSend, name, password);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Stack(
            children: <Widget>[
              Container(
                  child: BackgroundImage(
                      'assets/fondos/diario de pensamientos.png')),
              Column(
                children: <Widget>[
                  TitleHeader("Pensamientos"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 252, 252, 10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TableCalendar(
                        rowHeight: MediaQuery.of(context).size.height * 0.075,
                        locale: 'es_ES',
                        headerStyle: HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                            titleTextStyle: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            headerPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10)),
                        focusedDay: selectedDay,
                        //currentDay: focusedDay,
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(Duration(days: 200)),
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        daysOfWeekVisible: true,
                        onDaySelected: (DateTime selectDay, DateTime focusDay) {
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusDay;
                            //currentedDay=cdDay;
                            selectedDayString =
                                DateFormat('yyyy-MM-dd').format(selectedDay);
                          });

                          print(selectedDayString);
                        },

                        selectedDayPredicate: (DateTime date) {
                          // use this to go to screen_form.dart

                          return isSameDay(selectedDay, date);
                        },
                        calendarStyle: CalendarStyle(
                            isTodayHighlighted: true,
                            selectedDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle: TextStyle(color: Colors.white),
                            todayDecoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                shape: BoxShape.circle)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.37,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.1), blurRadius: 3)
                      ],
                      color: Color.fromRGBO(128, 124, 183, 10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Modificar pensamiento",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
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
                                  controller: message,
                                  autofocus: false,
                                  decoration: InputDecoration.collapsed(
                                      hintText:
                                          "Escribir nuevo pensamiento ..."),
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Container(
                              width: 300,
                              height: 50,
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () async {
                                  Thought thought = Thought();
                                  var userName =
                                      await UserSecureStorage.getUsername();
                                  var password =
                                      await UserSecureStorage.getPassword();
                  
                                  thought.message = message.text;
                                  thought = await dataBaseHelper.createThoughts(
                                    widget.idSend,
                                    userName.toString(),
                                    password.toString(),
                                    thought,
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DiaryPage(widget.idSend)));
                                },
                                child: Text("MODIFICAR PENSAMIENTO",
                                    style: TextStyle(
                                        fontSize: 15.5,
                                        color:
                                            Color.fromRGBO(107, 174, 174, 10),
                                        fontWeight: FontWeight.bold)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
