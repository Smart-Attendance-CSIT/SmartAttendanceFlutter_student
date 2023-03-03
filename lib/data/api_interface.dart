import 'package:dio/dio.dart';
import 'package:smart_attendance_student/data/api_service.dart';
import 'package:smart_attendance_student/models/group.dart';
import 'package:smart_attendance_student/models/login_params.dart';

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
        print('body');
        print(rs.body);
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
}
