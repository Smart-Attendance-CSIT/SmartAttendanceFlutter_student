import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendance_student/data/api_interface.dart';
import 'package:smart_attendance_student/main.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_attendance_student/models/group.dart';
import 'package:smart_attendance_student/presentation/screens/options.dart';
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
      body: FutureBuilder(
        future: getGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // show snackbar message
              return Text("Error Fetching Groups");
            } else {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: (Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.black)),
                                    elevation: 5,
                                    shadowColor: Colors.black,
                                    color: appColor4,
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(10),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OptionScreen(
                                              groupCode:
                                                  snapshot.data![index].id!,
                                              groupName:
                                                  snapshot.data![index].name!,
                                            ),
                                          ),
                                        );

                                        // jumpToOptionScreen(context)
                                      },
                                      title: Text(
                                        snapshot.data![index].name!,
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
                      ]),
                );
              }
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List<Group>> getGroups() async {
    ApiInterface apiInterface = ApiInterface();
    List<Group> groupList = await apiInterface.getGroups();
    return groupList;
  }
}
