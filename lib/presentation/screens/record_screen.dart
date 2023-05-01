import 'package:flutter/material.dart';
import 'package:smart_attendance_student/models/student_summary.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/constants/app_theme.dart';

class RecordScreen extends StatefulWidget {
  final StudentSummary studentSummary;
  const RecordScreen({super.key, required this.studentSummary});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
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
        backgroundColor: mainColor,
        title: Text(
          'Attendance Record',
          style: TextStyle(color: textColor),
        ),
        centerTitle: true,
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
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(), color: mainColor),
                padding: const EdgeInsets.all(20),
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
              const SizedBox(
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
                      (widget.studentSummary.pRESENT ?? 0).toString(),
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      (widget.studentSummary.aBSENT ?? 0).toString(),
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      (widget.studentSummary.lATE ?? 0).toString(),
                      style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      (widget.studentSummary.uNKNOWN ?? 0).toString(),
                      style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Present",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "Absent",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "Late",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "Unknown",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
              child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "Attendance Percentage:",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ((((widget.studentSummary.pRESENT ?? 0) +
                                        (widget.studentSummary.lATE ?? 0)) /
                                    ((widget.studentSummary.pRESENT ?? 0) +
                                        (widget.studentSummary.lATE ?? 0) +
                                        (widget.studentSummary.uNKNOWN ?? 0) +
                                        (widget.studentSummary.aBSENT ?? 0))) *
                                100)
                            .roundToDouble()
                            .toString(),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "%",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
