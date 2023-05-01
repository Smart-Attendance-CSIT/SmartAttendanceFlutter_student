import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendance_student/presentation/screens/options.dart';

import '../../config/constants/app_theme.dart';
import '../../config/constants/navigation/app_navigation.dart';
import '../../data/api_interface.dart';
import '../../models/group.dart';

const tileColors = [appColor2, appColor3, appColor4];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                // color: Theme.of(context).primaryColor,
                color: mainColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text('SMART ATTENDANCE',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: textColor, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '\n${userFirstName} ${userLastName} \n$userEmail',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: textColor)),
                    trailing: CircleAvatar(
                      backgroundColor: buttonColor,
                      radius: 30,
                      // backgroundImage: ,
                      child: Icon(
                        Icons.account_box_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString("user", "");
                        sharedPreferences.setString("key", "");
                        jumpToLoginScreen(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: mainColor,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80))),
                  height: 600,
                  child: FutureBuilder(
                      future: getGroups(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            // show snackbar message
                            return Text("Error Fetching Groups");
                          } else {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // return Container();
                                    return GestureDetector(
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
                                      },
                                      child: itemDashboard(
                                          snapshot.data![index].name!,
                                          Icons.library_books_outlined,
                                          tileColors[index % 3]),
                                    );
                                  });
                            }
                          }
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })),
            ),
          )
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 3,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.black)),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: textColor),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );

  Future<List<Group>> getGroups() async {
    ApiInterface apiInterface = ApiInterface();
    List<Group> groupList = await apiInterface.getGroups();
    return groupList;
  }
}
