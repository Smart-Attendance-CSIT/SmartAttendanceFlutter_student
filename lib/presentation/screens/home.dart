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
  String userFirstName = "";
  String userLastName = "";
  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    getStudentInformation();

    super.initState();
  }

  void getStudentInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userFirstName = sharedPreferences.getString("userFirstName")!;
      userLastName = sharedPreferences.getString("userLastName")!;
      userEmail = sharedPreferences.getString("userEmail")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${userFirstName} ${userLastName}'),
                ],
              ),
              accountEmail: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userEmail),
                ],
              ),
              currentAccountPicture: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.account_circle_rounded),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                TextButton(
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
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColor1,
        title: const Text(
          "Smart Attendance",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
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
