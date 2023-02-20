import 'package:flutter/material.dart';
import 'package:smart_attendance_student/config/constants/nav_constants.dart';
import 'package:smart_attendance_student/config/constants/navigation/config_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Attendance',
      theme:
          ThemeData(brightness: Brightness.light, primaryColor: Colors.black),
      initialRoute: valSplashScreen,
      // initialRoute: valHomeScreen,

      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
