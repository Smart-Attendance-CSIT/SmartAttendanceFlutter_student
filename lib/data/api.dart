import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:smart_attendance_student/data/api_service.dart';

class Api {
  Dio dio = Dio();

  void getClient() async {
    dio.options.baseUrl = Apiconstants.apiUrl;
    dio.options.headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      // TODO: After implementation of token this lines of code will be uncomment.
      // HttpHeaders.authorizationHeader:
      //     "Bearer " + SpUtil.getString(Constants.authToken),
    };

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
  }
}
