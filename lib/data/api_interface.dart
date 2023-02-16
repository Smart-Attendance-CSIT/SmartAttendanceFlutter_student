import 'package:dio/dio.dart';
import 'package:smart_attendance_student/data/api_service.dart';
import 'package:smart_attendance_student/models/login_params.dart';

import 'api.dart';
import 'network_response.dart';

class ApiInterface {
  Api apiClient = Api();

  Future<NetworkResponse> login(Loginparams loginparams) async {
    apiClient.getClient();
    NetworkResponse rs = NetworkResponse();

    try {
      await apiClient.dio
          .post(Apiconstants.loginUrl, data: loginparams)
          .then((response) {
        rs.status = response.statusCode;
        rs.body = response.data;
        print('body');
        print(rs.status);
      });
    } on DioError catch (e) {
      rs.status = e.response!.statusCode;
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
}
