import 'package:flutter/material.dart';
import 'package:smart_attendance_student/config/constants/nav_constants.dart';
import 'package:smart_attendance_student/presentation/screens/error.dart';
import 'package:smart_attendance_student/presentation/screens/home.dart';
import 'package:smart_attendance_student/presentation/screens/login.dart';
import 'package:smart_attendance_student/presentation/screens/options.dart';
import 'package:smart_attendance_student/presentation/screens/splash_screen.dart';
import 'package:smart_attendance_student/presentation/screens/class_screen.dart';

import '../../../presentation/screens/leave.dart';

// This class generates routes for each nav constants for using named routes.
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case valLoginScreen:
        return MaterialPageRoute(
            builder: ((BuildContext context) => LoginScreen()));
      case valHomeScreen:
        return MaterialPageRoute(
            builder: ((BuildContext context) => const HomeScreen()));
      case valSplashScreen:
        return MaterialPageRoute(
            builder: ((BuildContext context) => const SplashScreen()));
      case valClassScreen:
        return MaterialPageRoute(
            builder: ((BuildContext context) => const ClassScreen()));
      case valOptionScreen:
        return MaterialPageRoute(
            builder: ((BuildContext context) => const OptionScreen()));

      case valLeaveScreen:
        return MaterialPageRoute(
            builder: ((BuildContext context) => const LeaveScreen()));

      default:
        return _errorRoute();
    }
  }
}

Route _errorRoute() {
  return MaterialPageRoute(builder: (context) {
    return const ErrorScreen(errorText: 'Error loading the page');
  });
}
