import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perimetro extends StatefulWidget {
  const Perimetro({Key? key}) : super(key: key);

  @override
  State<Perimetro> createState() => _PerimetroState();
}

class _PerimetroState extends State<Perimetro> {
  int perimetro = 0;
  String id_sexo = "";

  String diag = "";
  String texto1 = "";
  String imagen = "perimetro_bajo.png";
  Color? colortexto;

  @override
  void initState() {
    super.initState();
    getDiagnostico();
  }

  getDiagnostico() async {
    final prefs = await SharedPreferences.getInstance();

    int per = prefs.getInt("perimetro") ?? 0;
    var sexo = prefs.getString("id_sexo") ?? "";
    setState(() {
      perimetro = per;
      id_sexo = sexo;
      if ((per < 94 && sexo == '1') || (per < 80 && sexo == '2')) {
        diag = "RIESGO BAJO";
        texto1 =
            "PAB < 94 cm en varones y < 80 cm en mujeres (bajo) Existe bajo riesgo de comorbilidad, de enfermedades crónicas no transmisibles como diabetes mellitus tipo 2, enfermedades cardiovasculares incluida la hipertensión arterial, enfermedad coronaria, entre otras.";
        imagen = "perimetro_bajo.png";
        colortexto = Colors.green;
      } else if ((per < 102 && sexo == '1') || (per < 88 && sexo == '2')) {
        diag = "RIESGO ALTO";
        texto1 =
            "PAB ≥ 94 cm en varones y ≥ 80 cm en mujeres (alto) Es considerado factor de alto riesgo de comorbilidad, de enfermedades crónicas no transmisibles como diabetes mellitus tipo 2, enfermedades cardiovasculares incluida la hipertensión arterial, enfermedad coronaria, entre otras.";

        imagen = "perimetro_alto.png";
        colortexto = Colors.orange;
      } else if ((per >= 102 && sexo == '1') || (per >= 88 && sexo == '2')) {
        diag = "RIESGO MUY ALTO";
        texto1 =
            "PAB ≥ 102 cm en varones y ≥ 88 cm en mujeres (muy alto) Es considerado factor de muy alto riesgo de comorbilidad, de enfermedades crónicas no transmisibles como diabetes mellitus tipo 2, enfermedades cardiovasculares incluida la hipertensión arterial, enfermedad coronaria, entre otras. ";
        imagen = "perimetro_muyalto.png";
        colortexto = Colors.red;
      } else {
        diag = "RIESGO BAJO";
        texto1 =
            "PAB < 94 cm en varones y < 80 cm en mujeres (bajo) Existe bajo riesgo de comorbilidad, de enfermedades crónicas no transmisibles como diabetes mellitus tipo 2, enfermedades cardiovasculares incluida la hipertensión arterial, enfermedad coronaria, entre otras.";
        imagen = "perimetro_bajo.png";
        colortexto = Colors.green;
      }
    });
  }

  getSerxo(id) {
    if (id == '1') {
      return "Masculino";
    } else if (id == '2') {
      return "Femenino";
    } else {
      return "No definino";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perímetro'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: <Color>[Colors.orange[200]!, Colors.green[800]!]),
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "P. A.: $perimetro cm",
                      ),
                      Text(
                        "Sexo: " + getSerxo(id_sexo),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image(
                    height: 200,
                    image: AssetImage('assets/img/$imagen'),
                  ),
                  Text(
                    '$perimetro cm',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    diag,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, color: colortexto),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    texto1,
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.grey[800]!, Color.fromARGB(255, 120, 113, 10)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
              child: const Text("UNHEVAL",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w200)),
            )
          ],
        ),
    );
  }
}
