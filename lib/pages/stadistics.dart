import 'package:app_muevete/models/health_stats.dart';
import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/pages/welcome.dart';
import 'package:app_muevete/utils/tema.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stadistcs extends StatefulWidget {
  const Stadistcs({Key? key}) : super(key: key);

  @override
  State<Stadistcs> createState() => _StadistcsState();
}

class _StadistcsState extends State<Stadistcs> {
  final _edadController = TextEditingController(text: '');
  final _estaturaController = TextEditingController(text: '');
  final _pesoController = TextEditingController(text: '');
  final _perimetroController = TextEditingController(text: '');
  String _sexo = '';
  HealthStats? _health_stats;
  int _age = 0;
  double _height = 1.0;
  double _weight = 0;
  double _perimeter = 0;
  double _imc = 0;
  int _riesgo = 0;

  @override
  void initState() {
    loadSexo();
    super.initState();
  }

  Widget progress() {
    /* if (_health_stats != null) { */
    _imc = _weight / ((_height / 100) * (_height / 100));
    _calcRiesgo();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: LinearProgressIndicator(
        minHeight: 10,
        value: _imc / 50,
        valueColor: AlwaysStoppedAnimation<Color>(colorProgress()),
        backgroundColor: Colors.grey[200],
      ),
    );
    /* } else {
      return Container();
    } */
  }

  Color colorProgress() {
    if (_imc < 18.5) {
      return Colors.red;
    } else if (_imc < 25) {
      return Colors.green;
    } else if (_imc < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Text textProgress() {
    if (_imc < 18.5) {
      return Text(
        'PESO BAJO',
        style: TextStyle(
            color: Colors.red[200], fontWeight: FontWeight.bold, fontSize: 20),
      );
    } else if (_imc < 25) {
      return Text(
        'Normal',
        style: TextStyle(
            color: Colors.green[200],
            fontWeight: FontWeight.bold,
            fontSize: 20),
      );
    } else if (_imc < 30) {
      return Text(
        'SOBRE PESO',
        style: TextStyle(
            color: Colors.orange[200],
            fontWeight: FontWeight.bold,
            fontSize: 20),
      );
    } else {
      return Text(
        'OBESIDAD',
        style: TextStyle(
            color: Colors.red[200], fontWeight: FontWeight.bold, fontSize: 20),
      );
    }
  }

  //Partes de la aplicación

  Widget _inputText(placeholder, controller) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor: Colors.grey[300],
          filled: true,
          hintText: placeholder,
          isDense: true),
    );
  }

  Widget _tableFormulario() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(4),
        },
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Edad',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              _inputText('Años', _edadController),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Estatura',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              _inputText('cm', _estaturaController),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Peso',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              _inputText('Kg', _pesoController),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Perimetro abdominal',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              _inputText('cm', _perimetroController),
            ],
          ),
        ],
      ),
    );
  }

  Widget _grafico() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(children: [
          Container(
            child: Text(
              'Indice de masa corporal',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
          ),
          progress(),
          Container(child: _getIMC()),
          textProgress(),
        ]));
  }

  Widget _buttonCalcular() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RaisedButton(
        child: Text('Calcular'),
        onPressed: () {
          setState(() {
            _age = int.parse(_edadController.text);
            _height = double.parse(_estaturaController.text);
            _weight = double.parse(_pesoController.text);
            _perimeter = double.parse(_perimetroController.text);
          });
        },
      ),
    );
  }

  Widget _btnContinuar(String text) {
    return ElevatedButton(
      onPressed: () async {
        if (_imc != 0 && _riesgo != 0) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setDouble('actual_weigth', _weight);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
          );
        }
      },
      style: TextButton.styleFrom(
          backgroundColor: Colors.green[800],
          padding: const EdgeInsets.all(15),
          minimumSize: const Size(double.infinity, 50),
          shape: StadiumBorder()),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _getIMC() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '${_imc.toStringAsFixed(2)}',
        style: TextStyle(
            fontSize: 50, fontWeight: FontWeight.bold, color: colorProgress()),
      ),
    );
  }

  loadSexo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sexo = prefs.getString('id_sexo') ?? '00';
    });
  }

  _calcRiesgo() {
    switch (_sexo) {
      case '1':
        if (_perimeter > 20.0 && _perimeter < 94.0) {
          _riesgo = 1;
        } else if (_perimeter >= 94.0 && _perimeter < 102.0) {
          _riesgo = 2;
        } else if (_perimeter >= 102.0) {
          _riesgo = 3;
        } else {
          _riesgo = 0;
        }
        break;
      case '2':
        if (_perimeter > 18.0 && _perimeter < 80.0) {
          _riesgo = 1;
        } else if (_perimeter >= 80.0 && _perimeter < 88.0) {
          _riesgo = 2;
        } else if (_perimeter >= 88.0) {
          _riesgo = 3;
        } else {
          _riesgo = 0;
        }
        break;
      default:
        _riesgo = 0;
        break;
    }
  }

  Widget _graficoRiesgo() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(children: [
          Container(
            child: Text(
              'Clasificación de riesgo (en base al sexo y perimetro abdominal)',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
          ),
          _progressRiesgo(),
          _textProgressRiesgo(),
        ]));
  }

  Widget _progressRiesgo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: LinearProgressIndicator(
        minHeight: 10,
        value: _riesgo / 3,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(colorProgressRiesgo()),
      ),
    );
  }

  Widget _textProgressRiesgo() {
    if (_riesgo == 0) {
      return Container();
    } else if (_riesgo == 1) {
      return Text(
        'Riesgo bajo',
        style: TextStyle(
            color: Colors.green[200],
            fontWeight: FontWeight.bold,
            fontSize: 20),
      );
    } else if (_riesgo == 2) {
      return Text(
        'Riesgo alto',
        style: TextStyle(
            color: Colors.orange[200],
            fontWeight: FontWeight.bold,
            fontSize: 20),
      );
    } else if (_riesgo == 3) {
      return Text(
        'Riesgo muy alto',
        style: TextStyle(
            color: Colors.red[200], fontWeight: FontWeight.bold, fontSize: 20),
      );
    } else {
      return Container();
    }
  }

  Color colorProgressRiesgo() {
    if (_riesgo == 1) {
      return Colors.green;
    } else if (_riesgo == 2) {
      return Colors.orange;
    } else if (_riesgo == 3) {
      return Colors.red;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(children: <Widget>[
              _tableFormulario(),
              _buttonCalcular(),
              _grafico(),
              Container(height: 50.0, width: 50.0),
              _graficoRiesgo(),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _btnContinuar('Continuar'),
                  ),
                ),
              ),
            ])),
      ),
      appBar: AppBar(
        title: Text('Datos adicionales'),
      ),
    ));
  }
}
