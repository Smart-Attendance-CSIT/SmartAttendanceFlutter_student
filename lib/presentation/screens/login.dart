import 'package:flutter/material.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/my_button.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/my_textfield.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/square_tile.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

//text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //logUser In method
  void logIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(children: [
              const SizedBox(height: 50),

              //logo
              Icon(Icons.person, size: 100),

              //Welcome back,you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 10),

              //userfield
              MyTextField(
                obscuredText: false,
                hintText: 'Username',
                controller: usernameController,
                prefixicon: const Icon(Icons.person),
              ),

              const SizedBox(height: 10),

              //passwordfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscuredText: true,
                prefixicon: const Icon(Icons.lock),
              ),

              const SizedBox(height: 10),

              //forget password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              //sign in button
              MyButton(
                onTap: logIn,
              ),

              const SizedBox(height: 50),

              //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              //google
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'assets/images/google.png'),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
