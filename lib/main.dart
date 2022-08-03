import 'package:app_muevete/models/exercise.dart';
import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/pages/intro.dart';
import 'package:app_muevete/pages/stadistics/actividad_fisica.dart';
import 'package:app_muevete/pages/stadistics/ejercicio.dart';
import 'package:app_muevete/pages/stadistics/imc.dart';
import 'package:app_muevete/pages/stadistics/perimetro.dart';
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
      title: 'App Muevete',
      debugShowCheckedModeBanner: false,
      theme: _themeData(),
      home: Home(),
      routes: {
        'imc': (context) => Imc(),
        'perimetro': (context) => Perimetro(),
        'actividad': (context) => ActividadFisica(),
        'nutricion': (context) => Home(),
        'ejercicio': (context) => Ejercicio(
            ejercicio: ModalRoute.of(context)?.settings.arguments as Exercise),
      },
    );
  }
}

ThemeData _themeData() {
  return ThemeData(
    primarySwatch: Colors.green,
  );
}
