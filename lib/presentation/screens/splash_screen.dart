import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text("Splash Screen"),
        onPressed: () => jumpToLoginScreen(context),
      ),
    );
  }
}
