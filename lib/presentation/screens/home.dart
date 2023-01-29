import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendance_student/main.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    height:
    MediaQuery.of(context).size.height;
    width:
    MediaQuery.of(context).size.width;
    List<String> name = [
      'Class 1',
      'Class 2',
      'Class 3',
      'Class 4',
      'Class 5',
      'Class 6'
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.purple,
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
          )),
          title: Text(
            "Attendance",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/sadikshya.png'),
              radius: 30,
            )
          ],
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      child: ListTile(
                        onTap: (() => jumpToClassScreen(context)),
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
                    ));
                  }),
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: FloatingActionButton(
              onPressed: (() {}),
              child: Icon(
                Icons.qr_code_scanner,
                size: 40,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
