import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendance_student/main.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../config/constants/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    height:
    MediaQuery.of(context).size.height;
    width:
    MediaQuery.of(context).size.width;
    List<String> name = [
      'Advanced Java Programming',
      'Software Project Management',
      'Data warehousing and data mining',
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColor1,
        title: const Text(
          "Classes",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString("user", "");
                sharedPreferences.setString("key", "");
                jumpToLoginScreen(context);
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: ListView.builder(
                itemCount: name.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: (Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: appColor4,
                      child: ListTile(
                        onTap: (() => jumpToOptionScreen(context)),
                        title: Text(
                          name[index].toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: const Icon(
                          Icons.menu_book,
                          color: Colors.black,
                          size: 27,
                        ),
                      ),
                    )),
                  );
                }),
          ),
          // SizedBox(
          //   height: 100,
          //   width: 100,
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       scanQRCode();
          //     },
          //     child: Icon(
          //       Icons.qr_code_scanner,
          //       size: 40,
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
