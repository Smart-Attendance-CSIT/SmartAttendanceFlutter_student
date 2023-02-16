import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Class 1'),
        leading: IconButton(
          onPressed: (() {}),
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.white12),
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
                Container(
                  padding: EdgeInsets.all(40),
                  height: 60,
                  color: Colors.deepPurple,
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
