import 'package:flutter/material.dart';
import 'package:fluttersqflitesample/screen/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqflite App',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: Login(),
    );
  }
}
