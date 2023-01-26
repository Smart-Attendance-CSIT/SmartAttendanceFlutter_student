import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendance_student/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    height:
    MediaQuery.of(context).size.height;
    width:
    MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 9,
          title: Text(
            "Attendance",
            style: TextStyle(color: Colors.black),
          ),
          leading: Icon(Icons.list),
          actions: <Widget>[
            IconButton(
              onPressed: (() {}),
              icon: Icon(
                Icons.account_circle,
                size: 40,
              ),
              color: Colors.black,
            )
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              Card(
                color: Colors.indigoAccent,
                child: ListTile(
                  title: Text('Class 1'),
                  subtitle: Text('Time: 6:00-6:50'),
                  leading: Icon(
                    Icons.menu_book,
                    color: Colors.black,
                    size: 27,
                  ),
                ),
              ),
              Card(
                color: Colors.indigoAccent,
                child: ListTile(
                  onTap: () {},
                  title: Text('Class 2'),
                  subtitle: Text('Time: 6:00-6:50'),
                  leading: Icon(
                    Icons.menu_book,
                    color: Colors.black,
                    size: 27,
                  ),
                ),
              ),
              Card(
                color: Colors.indigoAccent,
                child: ListTile(
                  title: Text('Class 3'),
                  subtitle: Text('Time: 6:00-6:50'),
                  leading: Icon(
                    Icons.menu_book,
                    color: Colors.black,
                    size: 27,
                  ),
                ),
              ),
              Card(
                color: Colors.indigoAccent,
                child: ListTile(
                  title: Text(
                    'Class 4',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Time: 6:00-6:50',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(
                    Icons.menu_book,
                    color: Colors.black,
                    size: 27,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
