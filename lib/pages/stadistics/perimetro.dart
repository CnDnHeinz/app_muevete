import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Perimetro extends StatelessWidget {
  const Perimetro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perímetro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Perimetro  abdominal: 88cm",
                ),
                Text(
                  "Sexo: Masculino",
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: const Image(
                image: AssetImage('assets/img/perimetro_bajo.png'),
              ),
              height: 200,
            ),
            Text(
              '88cm',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'RIESGO BAJO',
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
              'PAB < 94 cm en varones y < 80 cm en mujeres (bajo) Existe bajo riesgo de comorbilidad, de enfermedades crónicas no transmisibles como diabetes mellitus tipo 2, enfermedades cardiovasculares incluida la hipertensión arterial, enfermedad coronaria, entre otras.',
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
