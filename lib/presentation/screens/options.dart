import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';
import 'package:smart_attendance_student/presentation/screens/leave.dart';
import 'package:smart_attendance_student/presentation/screens/summary.dart';

import '../../config/constants/app_theme.dart';
import '../../data/api_interface.dart';

class OptionScreen extends StatefulWidget {
  final String groupName;
  final String groupCode;
  const OptionScreen(
      {super.key, required this.groupCode, required this.groupName});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  Position? _currentPosition;
  var getResult = 'QR Code Result';
  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      String attendanceId = qrCode.split(",").last;
      String qrToken = qrCode.split(",").first;
      await _getCurrentPosition();

      String uploadMessage = await submitQrForAttendance(
          _currentPosition?.latitude ?? 0,
          _currentPosition?.longitude ?? 0,
          qrToken,
          attendanceId);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          widget.groupName,
          style: TextStyle(color: textColor),
        ),
        centerTitle: true,
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 4,
          crossAxisCount: 1,
          mainAxisSpacing: 0.001,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () async {
                await _handleLocationPermission();
                scanQRCode();
              },
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 5),
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          spreadRadius: 3,
                          blurRadius: 5)
                    ]
                    // border: Border.all(width: 1.0, color: Colors.black),

                    ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 30,
                        child: const Icon(
                          Icons.qr_code_outlined,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Scan QR",
                        style: TextStyle(color: textColor, fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaveScreen(
                        groupCode: widget.groupCode,
                      ),
                    ));
              },
              child: Container(
                padding: EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 5),
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          spreadRadius: 3,
                          blurRadius: 5)
                    ]
                    // border: Border.all(width: 1.0, color: Colors.black),

                    ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 30,
                        child: const Icon(
                          Icons.note_add_outlined,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Leave Request",
                        style: TextStyle(color: textColor, fontSize: 20),
                      ),
                      SizedBox(
                        width: 65,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                // jumpToSummaryScreen(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryScreen(
                        groupCode: widget.groupCode,
                      ),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 5),
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          spreadRadius: 3,
                          blurRadius: 5)
                    ]
                    // border: Border.all(width: 1.0, color: Colors.black),

                    ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 30,
                        child: const Icon(
                          Icons.assignment_outlined,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Summary",
                        style: TextStyle(color: textColor, fontSize: 20),
                      ),
                      SizedBox(
                        width: 110,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> submitQrForAttendance(
      double lat, double lng, String token, String attendanceId) async {
    String uploadStatus = "";
    ApiInterface apiInterface = ApiInterface();
    setState(() {
      // isLoading = true;
    });
    try {
      uploadStatus = await apiInterface.submitQrForAttendance(
          lat: lat, lng: lng, token: token, attendanceId: attendanceId);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(uploadStatus)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
    return uploadStatus;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
