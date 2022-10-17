import 'package:app_muevete/components/cronometro_component.dart';
import 'package:app_muevete/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Ejercicio extends StatefulWidget {
  final Exercise? ejercicio;
  const Ejercicio({Key? key, this.ejercicio}) : super(key: key);

  @override
  State<Ejercicio> createState() => _EjercicioState();
}

class _EjercicioState extends State<Ejercicio> {
  final _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: <Widget>[
            Text(
              "Fecha : ${_today.day.toString()}/${_today.month.toString()}/${_today.year.toString()}",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 200,
              child: Image(
                image: AssetImage('assets/img/' +
                    (widget.ejercicio?.image ?? 'logo-app.png')),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.ejercicio?.name ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.ejercicio?.description ?? '',
            ),
            const SizedBox(
              height: 40,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Duración: ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                  TextSpan(
                    text: '${widget.ejercicio?.time ?? '0'}' + ' min',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            CronometroComponent(
              duracion: int.parse(widget.ejercicio?.time ?? '0'),
              ejercicio: widget.ejercicio,
            ),
          ],
        ),
      ),
    );
  }
}
