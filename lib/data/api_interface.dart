import 'package:dio/dio.dart';
import 'package:smart_attendance_student/data/api_service.dart';
import 'package:smart_attendance_student/models/group.dart';
import 'package:smart_attendance_student/models/login_params.dart';
import 'package:smart_attendance_student/models/student_summary.dart';

import 'api.dart';
import 'network_response.dart';

class ApiInterface {
  Api apiClient = Api();

  Future<NetworkResponse> login(Loginparams loginparams) async {
    await apiClient.getClient();
    NetworkResponse rs = NetworkResponse();

    try {
      await apiClient.dio
          .post(Apiconstants.loginUrl, data: loginparams.toJson())
          .then((response) {
        rs.status = response.statusCode;
        rs.body = response.data;
      });
    } on DioError catch (e) {
      rs.body = e.response!.data;
    }
    return rs;
  }

  Future<NetworkResponse> testget() async {
    apiClient.getClient();
    NetworkResponse rs = NetworkResponse();
    try {
      await apiClient.dio.get(Apiconstants.loginUrl).then((response) {
        rs.status = response.statusCode;
        rs.body = (response.data);
      });
    } on DioError catch (e) {
      rs.status = e.response!.statusCode;
      rs.body = e.response!.data;
    }
    return rs;
  }

  Future<List<Group>> getGroups() async {
    await apiClient.getClient();
    List<Group> groupsList = [];
    try {
      await apiClient.dio.get(Apiconstants.getAllGroupsUrl).then((response) {
        if (response.statusCode == 200) {
          var responseData = response.data;
          for (Map<String, dynamic> element in responseData['groups']) {
            var group = Group.fromJson(element);
            groupsList.add(group);
          }
        } else if (response.statusCode == 404) {}
      });
    } catch (e) {}
    return groupsList;
  }

  Future<String> leaveRequest(
      {required String date,
      required String message,
      required String groupId}) async {
    String uploadMessage = "Something went wrong";
    await apiClient.getClient();
    try {
      await apiClient.dio.post("/groups/$groupId/leaverequest",
          data: {"date": date, "requestMessage": message}).then((response) {
        uploadMessage = response.data['msg'];
      });
    } catch (e) {}
    return uploadMessage;
  }

  Future<String> submitQrForAttendance(
      {required String token,
      required double lat,
      required double lng,
      required String attendanceId}) async {
    String uploadMessage = "Something went wrong";
    await apiClient.getClient();
    try {
      await apiClient.dio.post("/attendances/$attendanceId/submit",
          data: {"qrToken": token, "lat": lat, "lng": lng}).then((response) {
        uploadMessage = response.data['msg'];
      });
    } catch (e) {}
    return uploadMessage;
  }

//student selfSummary
  Future<StudentSummary> getStudentSelfSummary(
      {required String startDate,
      required String endDate,
      required String groupId}) async {
    await apiClient.getClient();
    StudentSummary studentSummary;
    var response =
        await apiClient.dio.post(Apiconstants.getStudentSelfSummaryUrl);

    studentSummary = StudentSummary.fromJson(response.data['summary']);

    return studentSummary;
  }
}
