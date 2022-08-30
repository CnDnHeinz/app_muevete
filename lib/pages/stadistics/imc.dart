import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Imc extends StatefulWidget {
  const Imc({Key? key}) : super(key: key);

  @override
  State<Imc> createState() => _ImcState();
}

class _ImcState extends State<Imc> {
  double peso = 0.0;
  double estatura = 0.0;
  double imc = 0.0;

  String diag = "";
  String texto1 = "";
  String texto2 = "";
  String imagen = "male_normal";
  Color? colortexto;

  @override
  void initState() {
    super.initState();
    getPrefs();
    getDiagnostico();
  }

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    //print(prefs.getKeys());
    setState(() {
      peso = prefs.getDouble("peso") ?? 0.0;
      estatura = prefs.getDouble("estatura") ?? 0.0;
      imc = prefs.getDouble("imc") ?? 0.0;
    });
  }

  getDiagnostico() async {
    final prefs = await SharedPreferences.getInstance();

    var indice = prefs.getDouble("imc") ?? 0.0;
    var sexo = prefs.getString("id_sexo") ?? '';
    setState(() {
      if (indice < 18.5) {
        diag = "PESO BAJO";
        texto1 =
            "Su IMC es $indice, lo que indica que su peso está en la categoría de Bajo peso para adultos de su misma estatura.";
        texto2 =
            "Hable con su proveedor de atención médica para establecer las posibles causas del bajo peso y si necesita ganar peso.";
        imagen = (sexo == '2') ? "female_normal" : "male_normal";
        colortexto = Colors.red;
      } else if (indice < 25) {
        diag = "PESO NORMAL";
        texto1 =
            "Su IMC es $indice, lo que indica que su peso está en la categoría Normal para adultos de su misma estatura.";
        texto2 =
            "Mantener un peso saludable puede reducir el riesgo de enfermedades crónicas asociadas al sobrepeso y la obesidad.";

        imagen = (sexo == '2') ? "female_normal" : "male_normal";
        colortexto = Colors.green;
      } else if (indice < 30) {
        diag = "SOBREPESO";
        texto1 =
            "Su IMC es $indice, lo que indica que su peso está en la categoría de Sobrepeso para adultos de su misma estatura. ";
        texto2 =
            "Las personas que tienen sobrepeso o son obesas tienen un mayor riesgo de afecciones crónicas, tales como hipertensión arterial, diabetes y colesterol alto.";
        imagen = (sexo == '2') ? "female_medio" : "male_medio";

        print(sexo);
        colortexto = Colors.orange;
      } else {
        diag = "OBESIDAD";
        texto1 =
            "Su IMC es $indice, lo que indica que su peso está en la categoría de Sobrepeso para adultos de su misma estatura. ";
        texto2 =
            "Las personas que tienen sobrepeso o son obesas tienen un mayor riesgo de afecciones crónicas, tales como hipertensión arterial, diabetes y colesterol alto.";
        imagen = (sexo == '2') ? "female_gordo" : "male_gordo";
        colortexto = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indice de masa corporal'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: <Color>[Colors.orange[200]!, Colors.green[800]!]),
          ),
        ),
      ),
      body: Center(
        child: Column(
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
                          "Estatura: $estatura cm",
                        ),
                        Text(
                          "Peso: $peso kg",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image(
                      height: 180.0,
                      image: AssetImage(
                          'assets/img/avatar/avatar_' + imagen + '.png'),
                    ),
                    Text(
                      imc.toString(),
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        backgroundColor: colortexto
                        
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(texto1),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(texto2),
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
      ),
    );
  }
}
