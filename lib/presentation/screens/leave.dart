import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';
import 'package:smart_attendance_student/presentation/screens/check_status.dart';
import 'package:smart_attendance_student/presentation/screens/create_leave_request.dart';

import '../../config/constants/app_theme.dart';
import '../../data/api_interface.dart';

class LeaveScreen extends StatefulWidget {
  final String groupCode;
  const LeaveScreen({super.key, required this.groupCode});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(
            "Leave Request",
            style: TextStyle(color: textColor),
          ),
          centerTitle: true,
          bottom: TabBar(
              indicatorColor: whiteColor,
              indicatorPadding: const EdgeInsets.all(5),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "New Request",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Check Status",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                      ),
                    )),
              ]),
        ),
        body: TabBarView(
            physics: const BouncingScrollPhysics(),
            dragStartBehavior: DragStartBehavior.start,
            children: [
              CreateLeaveRequest(groupCode: widget.groupCode),
              CheckStatus(groupId: widget.groupCode)
            ]),
      ),
    );
  }
}
