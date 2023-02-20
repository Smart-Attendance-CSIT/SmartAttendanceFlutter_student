import 'package:flutter/material.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';

import '../../config/constants/app_theme.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  final _formKey = GlobalKey<FormState>();
//text editing controllers
  final nameController = TextEditingController();

  final reasonController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor1,
        title: Text("Leave Request"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 50),

                  //userfield
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter name',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  const SizedBox(height: 10),

                  //passwordfield
                  TextFormField(
                    controller: reasonController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter reason';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter reason of leave',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 50,
                    width: 500,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: appColor1),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Form submitted sucessfully")));
                            jumpToOptionScreen(context);
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),

                  const SizedBox(height: 50),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
