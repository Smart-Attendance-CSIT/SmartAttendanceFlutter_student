import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_attendance_student/config/constants/app_theme.dart';
import 'package:smart_attendance_student/models/leave_request_response.dart';
import 'package:smart_attendance_student/presentation/screens/error.dart';

import '../../data/api_interface.dart';

class CheckStatus extends StatefulWidget {
  final String groupId;
  const CheckStatus({super.key, required this.groupId});

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLeaveRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                contentPadding: EdgeInsets.all(10),
                                title: const Text(
                                  "Status Details",
                                  textAlign: TextAlign.center,
                                ),
                                children: [
                                  Text(
                                      "Date : ${snapshot.data![index].date!.substring(0, 10)}"),
                                  Text(
                                      "Reviewed By : ${snapshot.data![index].reviewedBy!.firstName} ${snapshot.data![index].reviewedBy!.lastName}"),
                                  Text(
                                      "Response Message : ${snapshot.data![index].responseMessage}"),
                                  Text(
                                      "Status :  ${snapshot.data![index].status}"),
                                ],
                              );
                            });
                      },
                      isThreeLine: true,
                      title: Text(snapshot.data![index].date!.substring(0, 10)),
                      subtitle: Text(
                        snapshot.data![index].requestMessage!,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          snapshot.data![index].status!,
                          style: TextStyle(
                              color: (snapshot.data![index].status ==
                                      "APPROVED")
                                  ? Colors.green
                                  : snapshot.data![index].status == "REJECTED"
                                      ? Colors.red
                                      : textColor),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    );
                  })
              : ErrorScreen(errorText: "You have no pending leave requests");
        } else {
          return const ErrorScreen(errorText: "Loading...");
        }
      },
    );
  }

  Future<List<LeaveRequests>> getLeaveRequests() async {
    ApiInterface apiInterface = ApiInterface();

    try {
      List<LeaveRequests> requestsList =
          await apiInterface.getLeaveRequests(groupId: widget.groupId);
      return requestsList;
    } catch (e) {
      //TODO show snackbar message cant fetch leave requests
    }

    return [];
  }
}
