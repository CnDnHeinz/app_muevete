import 'package:app_muevete/components/ejercicio_componente.dart';
import 'package:app_muevete/models/exercise.dart';
import 'package:app_muevete/services/exersice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class ActividadFisica extends StatefulWidget {
  const ActividadFisica({Key? key}) : super(key: key);

  @override
  State<ActividadFisica> createState() => _ActividadFisicaState();
}

class _ActividadFisicaState extends State<ActividadFisica>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ExersiceService _exerciseService = ExersiceService();
  List<Exercise> ejercicios = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    ejercicios = _exerciseService.getEjersiciosPrimerNivel();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Widget> generateEjercicios() {
    return ejercicios.map((e) => EjercicioComponente(exercise: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividad Física'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: generateEjercicios(),
        ),
      ),
    );
  }
}
