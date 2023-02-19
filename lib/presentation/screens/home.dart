import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendance_student/main.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Classes",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22.0),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Container(
              // color: Colors.blueGrey[500],
              child: ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      child: (Card(
                        elevation: 50,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        child: ListTile(
                          onTap: (() => jumpToOptionScreen(context)),
                          title: Text(
                            name[index].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            Icons.menu_book,
                            color: Colors.black,
                            size: 27,
                          ),
                        ),
                      )),
                    );
                  }),
            ),
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
