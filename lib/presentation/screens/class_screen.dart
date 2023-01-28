import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Class 1'),
        leading: IconButton(
          onPressed: (() {}),
          icon: Icon(
            Icons.menu,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(children: [
            TableCalendar(
              locale: 'en_us',
              rowHeight: 50,
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: ((day) => isSameDay(day, today)),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 13),
              onDaySelected: _onDaySelected,
            )
          ]),
        ),
      ),
    );
  }
}

// class ClassScreen extends StatefulWidget {
//   ClassScreen({super.key});
//   DateTime today = DateTime.now();
//   void _onDaySelected(DateTime day, DateTime focusedDay) {
//     sets
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: Text('Class 1'),
//         leading: IconButton(
//           onPressed: (() {}),
//           icon: Icon(
//             Icons.menu,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           child: Column(children: [
//             TableCalendar(
//               locale: 'en_us',
//               rowHeight: 50,
//               headerStyle:
//                   HeaderStyle(formatButtonVisible: false, titleCentered: true),
//               availableGestures: AvailableGestures.all,
//               focusedDay: today,
//               firstDay: DateTime.utc(2010, 10, 16),
//               lastDay: DateTime.utc(2030, 3, 13),
//               onDaySelected: _onDaySelected,
//             )
//           ]),
//         ),
//       ),
//     );
//   }
  
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
