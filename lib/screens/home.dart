import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/database/user_database.dart';
import 'package:mad_project/modals/user.dart';
import 'package:provider/provider.dart';
import 'package:simple_vertical_calendar/simple_vertical_calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _mlcontroller = TextEditingController();
  TextEditingController _plcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context) ??
        AppUser(
            name: "",
            periodLength: 0,
            menstrualLength: 0,
            lastMenstruation: []);
    User fireuser = Provider.of<User>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color.fromRGBO(251, 55, 144, 0.3),
                    Color.fromRGBO(222, 127, 170, 0.3),
                    //green
                  ]),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SUV',
                        style: TextStyle(
                          fontFamily: 'dsc',
                          fontSize: 40,
                          //color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/feminine.png'),
                        backgroundColor: Color.fromRGBO(120, 120, 120, 0),
                      ),
                      Text(
                        'DHA',
                        style: TextStyle(
                          fontFamily: 'dsc',
                          fontSize: 40,
                          //color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Period Tracker',
                      style: TextStyle(
                        fontFamily: 'playfair',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Menstrual Length',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user.menstrualLength.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('change Menstrual Length '),
                              content: new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                    keyboardType: TextInputType.number,
                                    controller: _mlcontroller,
                                  )
                                ],
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (_mlcontroller.text != null) {
                                      UserDatabase(uid: fireuser.uid)
                                          .updateUserData(AppUser(
                                              menstrualLength:
                                                  int.parse(_mlcontroller.text),
                                              periodLength: user.periodLength,
                                              name: user.name,
                                              lastMenstruation:
                                                  user.lastMenstruation));
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  textColor: Theme.of(context).primaryColor,
                                  child: const Text('ok'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  textColor: Theme.of(context).primaryColor,
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Periods length:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.periodLength.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('change Periods Length '),
                                content: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      keyboardType: TextInputType.number,
                                      controller: _plcontroller,
                                    )
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      if (_plcontroller.text != null) {
                                        UserDatabase(uid: fireuser.uid)
                                            .updateUserData(AppUser(
                                                menstrualLength:
                                                    user.menstrualLength,
                                                periodLength: int.parse(
                                                    _plcontroller.text),
                                                name: user.name,
                                                lastMenstruation:
                                                    user.lastMenstruation));
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    child: const Text('ok'),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Last Menstruation:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'value',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 600,
                  child: SimpleVerticalCalendar(
                    numOfMonth: 12,
                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlgin: TextAlign.left,
                      monthFormat: MonthFormats.FULL,
                    ),
                    calendarOption: CalendarOptions
                        .RANGE_SELECTION, // [RANGE_SELECTION, SINGLE]
                    dayOfWeekHeaderStyle: DayOfWeekHeaderStyle(),
                    dayStyle: DayHeaderStyle(
                      dateInRangeBackgroundColor: Colors.green,
                      textColor: Colors.green,
                      unavailableTextColor: Colors.pink,
                    ),
                    onDateTap: (start, end) {
                      print(start);
                      print(end);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
