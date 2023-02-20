import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/constants/app_theme.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor1,
        title: const Text('Attendance Record'),
        // leading: IconButton(
        //   onPressed: (() {}),
        //   icon: const Icon(
        //     Icons.menu,
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Column(children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(), color: appColor3),
                padding: EdgeInsets.all(20),
                child: TableCalendar(
                  locale: 'en_us',
                  rowHeight: 50,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: ((day) => isSameDay(day, today)),
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 13),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ]),
          ),
          Container(
            width: width,
            decoration: BoxDecoration(border: Border.all(), color: appColor1),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    Text(
                      "25 D",
                      style: TextStyle(
                          color: Colors.teal[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      "5 D",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      "83 % ",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Present",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        Text(
                          "Absent",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
