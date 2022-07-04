import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/pages/intro.dart';
import 'package:app_muevete/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Muvete',
      debugShowCheckedModeBanner: false,
      theme: _themeData(),
      home: Intro(),
    );
  }
}

ThemeData _themeData() {
  return ThemeData(
    primarySwatch: Colors.green,
  );
}

