import 'package:flutter/material.dart';
import 'package:sanitasi/screen/home.dart';
import 'package:sanitasi/screen/kantor.dart';
import 'package:sanitasi/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey Sanitasi',
      home: Kantor(),
    );
  }
}
