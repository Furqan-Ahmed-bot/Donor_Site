// import 'package:demo_app/date_time.dart';
// import 'package:demo_app/my_list.dart';
// import 'package:flutter/material.dart';

// import 'dashboard.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyAppOne(),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _timeString;
  String? _timeStringtwo;
  String? _timeStringthree;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    // final String formattedDateTime =
    //     DateFormat.MMMMd('yyyy-MM-dd \n kk:mm:ss').format(DateTime.now()).toString();

        DateFormat formatter =DateFormat.MMMEd('en_US');
        String date = formatter.format(DateTime.now()).toString();
        var dateSplit = date.split(',');
        
    setState(() {
      _timeString = dateSplit[0];
      _timeStringtwo = dateSplit[1];
      _timeStringthree = date;
      

      
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Display Current DateTime - Fluttercorner'),
        ),
        body: Center(
          child: Column(children: [
            Text(
          '$_timeString\n$_timeStringtwo\n$_timeStringthree',
          
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          ),

           Text(
          _timeStringtwo.toString(),
          
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          ),
          ],)
        ),
      ),
    );
  }
}
