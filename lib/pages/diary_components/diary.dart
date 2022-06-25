import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tp2022_front/Components/background_image.dart';
import 'package:tp2022_front/Components/bottom_navigation_bar.dart';
import 'package:tp2022_front/Components/calendar-widget.dart';
import 'package:tp2022_front/Components/labels.dart';
import 'package:tp2022_front/Components/screen_form.dart';
import 'package:tp2022_front/models/Thoughts.dart';
import 'package:tp2022_front/pages/home.dart';
import 'package:tp2022_front/security/user_secure_storage.dart';
import 'package:tp2022_front/utils/endpoints.dart';

class DiaryPage extends StatefulWidget {
  final String idSend;

  DiaryPage(this.idSend);
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("¿Deseas regresar al menú principal?"),
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

    print("sleepList: " + thoughtList.toString());
    print("first: " + thoughtList[0].toString());
    print("startDate first: " + thoughtList[0]["startDate"].toString());
    print("size: " + thoughtList.length.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                child: Stack(
              children: <Widget>[
                Container(
                    child: BackgroundImage(
                        'assets/fondos/diario de pensamientos.png')),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TitleHeader("Pensamientos"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 0),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(182, 220, 220, 10),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TableCalendar(
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
                          onDaySelected:
                              (DateTime selectDay, DateTime focusDay) {
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
                      Row(
                        children: [
                          H1Label("Mi lista de pensamientos"),
                          Container(
                              child: IconButton(
                            icon: Image.asset('assets/icons/add.png'),
                            iconSize: 20,
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  enableDrag: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AnimatedPadding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      duration: Duration(seconds: 1),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        padding: EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                                blurRadius: 3)
                                          ],
                                          color:
                                              Color.fromRGBO(128, 124, 183, 10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Nuevo pensamiento",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              height: 50,
                                              //color: Colors.white,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      245, 242, 250, 10),
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
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: TextField(
                                                      controller: message,
                                                      autofocus: false,
                                                      decoration: InputDecoration
                                                          .collapsed(
                                                              hintText:
                                                                  "Escribir nuevo pensamiento ..."),
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Container(
                                                  width: 300,
                                                  height: 50,
                                                  child: RaisedButton(
                                                    color: Colors.white,
                                                    onPressed: () async {
                                                      Thought thought =
                                                          Thought();
                                                      var userName =
                                                          await UserSecureStorage
                                                              .getUsername();
                                                      var password =
                                                          await UserSecureStorage
                                                              .getPassword();

                                                      thought.message =
                                                          message.text;
                                                      thought =
                                                          await dataBaseHelper
                                                              .createThoughts(
                                                        widget.idSend,
                                                        userName.toString(),
                                                        password.toString(),
                                                        thought,
                                                      );
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DiaryPage(widget
                                                                      .idSend)));
                                                    },
                                                    child: Text(
                                                        "REGISTRAR PENSAMIENTO",
                                                        style: TextStyle(
                                                            fontSize: 15.5,
                                                            color:
                                                                Color.fromRGBO(
                                                                    107,
                                                                    174,
                                                                    174,
                                                                    10),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ))
                        ],
                      ),
                      ThoughtsChart(context)
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        bottomNavigationBar: BottomNavigation(idSend: widget.idSend),
      ),
    );
  }

  Widget ThoughtsChart(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        for (int i = 0; i < thoughtList.length; i++)
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(246, 239, 227, 10),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                // ajust el tamaño de la columna
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          thoughtList[i]['message'],
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: PopupMenuButton<String>(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              tooltip: "Opciones",
                              /*onSelected: (String value) {
                                    if (value == "Eliminar") {
                                      dataBaseHelper.deleteReminder(
                                          remindersList[i]['id']);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReminderPage(widget.idSend)));
                                    }
                                  },*/
                              //padding: EdgeInsets.zero,
                              icon: Icon(Icons.more_horiz),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: "Modificar",
                                      child: ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text("Modificar"),
                                      ),
                                    ),
                                    PopupMenuItem<String>(
                                      value: "Eliminar",
                                      child: ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text("Eliminar"),
                                      ),
                                    )
                                  ]))
                    ],
                  ),
                  // negrita
                ],
              ),
            ),
          )
      ],
    ));
  }
}
