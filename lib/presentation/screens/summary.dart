import 'package:flutter/material.dart';
import 'package:smart_attendance_student/models/student_summary.dart';
import 'package:smart_attendance_student/presentation/screens/record_screen.dart';

import '../../config/constants/app_theme.dart';
import '../../data/api_interface.dart';

class SummaryScreen extends StatefulWidget {
  final String groupCode;
  const SummaryScreen({super.key, required this.groupCode});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();
//text editing controllers
  final startController = TextEditingController();

  final endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Attendance Summary",
          style: TextStyle(color: textColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Center(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Start Date:  ",
                    style: labelStyle,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().toUtc(),
                            firstDate: DateTime(1900).toUtc(),
                            lastDate: DateTime(2100).toUtc());
                        DateTime utcDatetime = date!.toUtc();

                        startController.text = utcDatetime.toIso8601String();
                      },
                      controller: startController,
                      decoration: const InputDecoration(
                        hintText: 'Select Start Date',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "End Date:  ",
                    style: labelStyle,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().toUtc(),
                            firstDate: DateTime(1900).toUtc(),
                            lastDate: DateTime(2100).toUtc());
                        DateTime utcDatetime = date!.toUtc();

                        endController.text = utcDatetime.toIso8601String();
                      },
                      controller: endController,
                      decoration: const InputDecoration(
                        hintText: 'Select End Date',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 500,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor),
                        onPressed: () {
                          getSummary(context, startController.text,
                              endController.text, widget.groupCode);
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getSummary(BuildContext context, String startDate,
      String endDate, String groupCode) async {
    ApiInterface apiInterface = ApiInterface();
    // setState(() {
    //   isLoading = true;
    // });
    try {
      StudentSummary studentSummary = await apiInterface.getStudentSelfSummary(
          startDate: startDate, endDate: endDate, groupId: groupCode);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecordScreen(
              studentSummary: studentSummary,
            ),
          ));
    } catch (e) {
      //TODO
      //Show snackbar message for cannot fetch student summary
    }
  }
}
