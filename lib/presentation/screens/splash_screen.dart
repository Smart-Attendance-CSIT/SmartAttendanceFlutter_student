import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendance_student/config/constants/assets_constants.dart';

import '../../config/constants/navigation/app_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getString('user') == "" || prefs.getString('user') == null) {
          jumpToLoginScreen(context);
        } else {
          jumpToHomeScreen(context);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    lottieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Smart Attendance",
                  ),
                ],
              ),
              const SizedBox(
                height: 52,
              ),
              Lottie.asset(splashAnimation,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                  controller: lottieController, onLoaded: (composition) {
                lottieController.forward();
              }),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Icon(
                      Icons.qr_code,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
