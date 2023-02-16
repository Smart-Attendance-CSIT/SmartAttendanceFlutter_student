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
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

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
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Attendance",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22.0),
        ),
        actions: const [
          Icon(
            Icons.person,
            size: 50,
            color: Colors.black,
          ),
        ],
        // actions:
        // Icon(Icons.person)
        // <Widget>[
        //   CircleAvatar(
        //     backgroundImage: AssetImage('assets/images/sadikshya.png'),
        //     radius: 30,
        //   )
        // ],
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
              onPressed: () {
                scanQRCode();
              },
              child: Icon(
                Icons.qr_code_scanner,
                size: 40,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
