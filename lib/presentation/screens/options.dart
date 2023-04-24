import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_attendance_student/config/constants/navigation/app_navigation.dart';
import 'package:smart_attendance_student/presentation/screens/leave.dart';

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
  var getResult = 'QR Code Result';
  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      print("QRCode_Result:--");
      print(qrCode);
      String attendanceId = qrCode.split(",").last;

      String uploadMessage =
          await submitQrForAttendance("5", "5", qrCode, attendanceId);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor1,
        title: Text(widget.groupName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  scanQRCode();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appColor3,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.qr_code_scanner,
                          size: 50,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Today's Attendance",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appColor3,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.note_add,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Leave Request",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  jumpToClassScreen(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appColor3,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.assignment,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Records",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> submitQrForAttendance(
      String lat, String lng, String token, String attendanceId) async {
    String uploadStatus = "";
    ApiInterface apiInterface = ApiInterface();
    setState(() {
      // isLoading = true;
    });
    try {
      uploadStatus = await apiInterface.submitQrForAttendance(
          lat: lat, lng: lng, token: token, attendanceId: attendanceId);
    } catch (e) {}
    return uploadStatus;
  }
}
