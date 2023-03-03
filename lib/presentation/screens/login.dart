import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendance_student/data/api_interface.dart';
import 'package:smart_attendance_student/models/login_params.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/my_button.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/my_textfield.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/square_tile.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';

import '../../config/constants/app_theme.dart';
import '../../models/student_response_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
//text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool _hidePassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      //logo
                      const Icon(
                        Icons.account_circle,
                        size: 100,
                        color: appColor1,
                      ),

                      //Welcome back,you've been missed!
                      Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      //userfield
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          if (!value.contains('@')) {
                            return 'Please Enter valid email';
                          }
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                        ),
                      ),

                      const SizedBox(height: 20),

                      //passwordfield
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                        },
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Enter Password',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // fillColor: Colors.grey.shade200,
                            filled: true,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: (_hidePassword)
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye_outlined),
                            )),
                      ),

                      const SizedBox(height: 20),

                      //sign in button

                      !isLoading
                          ? SizedBox(
                              height: 50,
                              width: 500,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      login(Loginparams(
                                          email: emailController.text,
                                          password: passwordController.text));
                                    }
                                  },
                                  child: const Text(
                                    'LogIn',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(Loginparams loginparams) {
    ApiInterface apiInterface = ApiInterface();
    setState(() {
      isLoading = true;
    });
    apiInterface.login(loginparams).then((res) async {
      StudentResponsemodel studentResponsemodel =
          StudentResponsemodel.fromJson(res.body);
      print(studentResponsemodel);
      if (studentResponsemodel.success == true) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("user", studentResponsemodel.user!.id!);
        sharedPreferences.setString("token", studentResponsemodel.token!);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Logged in!")));
        jumpToHomeScreen(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(studentResponsemodel.msg!)));
      }

      setState(() {
        isLoading = false;
      });
    });
  }
}
