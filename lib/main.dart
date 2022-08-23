import 'package:app_muevete/models/exercise.dart';
import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/pages/intro.dart';
import 'package:app_muevete/pages/stadistics/actividad_fisica.dart';
import 'package:app_muevete/pages/stadistics/ejercicio.dart';
import 'package:app_muevete/pages/stadistics/imc.dart';
import 'package:app_muevete/pages/stadistics/nutricion.dart';
import 'package:app_muevete/pages/stadistics/perimetro.dart';
import 'package:app_muevete/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';

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
      home: const Intro(),
      routes: {
        'imc': (context) => const Imc(),
        'perimetro': (context) => const Perimetro(),
        'actividad': (context) => const ActividadFisica(),
        'nutricion': (context) => const Nutricion(),
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
