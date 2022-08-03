import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Imc extends StatelessWidget {
  const Imc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Indice de masa corporal'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Estatura: 164cm",
                  ),
                  Text(
                    "Peso: 74kg",
                  ),
                ],
              ),
              Container(
                child: const Image(
                  image: AssetImage('assets/img/imc_sobrepeso.png'),
                ),
                height: 200,
              ),
              Text(
                '27.5',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'SOBREPESO',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Su IMC es 27.5, lo que indica que su peso está en la categoría de Sobrepeso para adultos de su misma estatura.',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Las personas que tienen sobrepeso o son obesas tienen un mayor riesgo de afecciones crónicas, tales como hipertensión arterial, diabetes y colesterol alto.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
