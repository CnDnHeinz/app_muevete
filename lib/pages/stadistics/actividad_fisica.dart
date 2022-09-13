import 'package:app_muevete/components/ejercicio_componente.dart';
import 'package:app_muevete/models/exercise.dart';
import 'package:app_muevete/services/exersice_service.dart';
import 'package:app_muevete/utils/app_colors.dart';
import 'package:flutter/material.dart';

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

  List<Widget> generateEjercicios(List<Exercise> ex) {
    return ex.map((e) => EjercicioComponente(exercise: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final builder = FutureBuilder<dynamic>(
      future: _exerciseService.getEjercicios(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return ListView(
            children: [
              ...[
                Text(
                  'NIVEL ${snapshot.data[0].level}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )
              ],
              ...generateEjercicios(snapshot.data)
            ],
          );
        }
        return const Center(
          child: Text('Servidor no está disponible'),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad Física'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: <Color>[Colors.orange[200]!, Colors.green[800]!]),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: builder,
      ),
    );
  }
}
