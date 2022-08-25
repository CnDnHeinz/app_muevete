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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicio'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('assets/img/' +
                    (widget.ejercicio?.image ?? 'logo-app.png')),
              ),
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.ejercicio?.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.ejercicio?.description ?? '',
            ),
            SizedBox(
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
