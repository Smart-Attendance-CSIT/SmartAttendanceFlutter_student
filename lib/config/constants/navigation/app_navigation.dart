import 'package:flutter/material.dart';
import 'package:smart_attendance_student/config/constants/nav_constants.dart';

//All the app navigation in a single place

void jumpToSplashScreen(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(valSplashScreen, (_) => false);
}

void jumpToHomeScreen(BuildContext context) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil(valHomeScreen, (route) => false);
}

void jumpToLoginScreen(BuildContext context) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil(valLoginScreen, (route) => false);
}

void jumpToClassScreen(BuildContext context) {
  Navigator.of(context).pushNamed(valClassScreen);
}

// void jumpToOptionScreen(BuildContext context) {
//   Navigator.of(context).pushNamed(valOptionScreen);
// }

void jumpToLeaveScreen(BuildContext context) {
  Navigator.of(context).pushNamed(valLeaveScreen);
}

void jumpToSummaryScreen(BuildContext context) {
  Navigator.of(context).pushNamed(valSummaryScreen);
}
