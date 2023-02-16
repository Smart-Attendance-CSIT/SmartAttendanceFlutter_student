import 'package:flutter/material.dart';
import 'package:smart_attendance_student/data/api_interface.dart';
import 'package:smart_attendance_student/models/login_params.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/my_button.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/my_textfield.dart';
import 'package:smart_attendance_student/presentation/screens/widgets/square_tile.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';

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

  //logUser In method
  void logIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 50),

                  //logo
                  const Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.deepPurple,
                  ),

                  //Welcome back,you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //userfield
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      }
                      if (!value.contains('@')) {
                        return 'Please Enter valid email';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter Email',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //passwordfield
                  TextFormField(
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
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
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
                  SizedBox(
                    height: 50,
                    width: 500,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login(Loginparams(
                                email: emailController.text,
                                password: passwordController.text));
                          }

                          // if (emailController.text.isEmpty) {
                          //   print(
                          //       'Value is Available ${emailController.text.trim()}');
                          // } else if (emailController.text.isNotEmpty) {}
                        },
                        child: const Text(
                          'LogIn',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
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
                    children: const [
                      SquareTile(imagePath: 'assets/images/google.png'),
                    ],
                  ),
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
    apiInterface.login(loginparams).then((res) {
      if (res.status == 200) {
        var data = res.body;
        print(data);
        if (data.length > 0) {
          final StudentResponsemodel studentResponsemodel =
              StudentResponsemodel.fromJson(data);
          // StudentResponsemodel studentResponsemodel =
          //     data.map<StudentResponsemodel>(
          //         (json) => StudentResponsemodel.fromJson(json));
          print(studentResponsemodel.user!.firstName);
          jumpToHomeScreen(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Login Sucessfully")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email or Password incorrect")));
      }
    });
  }
}
