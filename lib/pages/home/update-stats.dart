import 'package:app_muevete/components/app_button.dart';
import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/services/stadistics_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateStats extends StatefulWidget {
  const UpdateStats({Key? key}) : super(key: key);

  @override
  State<UpdateStats> createState() => _UpdateStatsState();
}

class _UpdateStatsState extends State<UpdateStats> {
  final _edadController = TextEditingController(text: '');
  final _estaturaController = TextEditingController(text: '');
  final _pesoController = TextEditingController(text: '');
  final _perimetroController = TextEditingController(text: '');
  final _stadisticService = StadisticsService();
  int _age = 0;
  double _height = 1.0;
  double _weight = 0;
  double _perimeter = 0;
  double _imc = 0;
  int _riesgo = 0;

  @override
  void initState() {
    _loadEdad();
    super.initState();
  }

  Widget _inputText(placeholder, controller, tamanio) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      maxLength: tamanio,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
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

  _loadEdad() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _age = prefs.getInt('edad') ?? 0;
      _edadController.text = (prefs.getInt('edad') ?? 0).toString();
    });
  }

  Widget _formulario() {
    double fsize = 17.0;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(4),
        },
        children: [
          TableRow(
            children: [
              Text(
                'Edad',
                style: TextStyle(fontSize: fsize),
              ),
              _inputText('Años', _edadController, 2),
            ],
          ),
          TableRow(
            children: [
              Text(
                'Estatura',
                style: TextStyle(fontSize: fsize),
              ),
              _inputText('cm', _estaturaController, 4),
            ],
          ),
          TableRow(
            children: [
              Text(
                'Peso',
                style: TextStyle(fontSize: fsize),
              ),
              _inputText('Kg', _pesoController, 4),
            ],
          ),
          TableRow(
            children: [
              Text(
                'Perímetro abdominal',
                style: TextStyle(fontSize: fsize),
              ),
              _inputText('cm', _perimetroController, 4),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _formulario(),
            const SizedBox(height: 20.0),
            AppButton(
              label: "Guardar información",
              fontWeight: FontWeight.w600,
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setDouble('peso', double.parse(_pesoController.text));
                prefs.setDouble(
                    'estatura', double.parse(_estaturaController.text));
                prefs.setInt('edad', int.parse(_edadController.text));
                prefs.setDouble(
                    'perimetro', double.parse(_perimetroController.text));
                _stadisticService.submitStadistics({
                  'edad': int.parse(_edadController.text),
                  'estatura': double.parse(_estaturaController.text),
                  'peso': double.parse(_pesoController.text),
                  'perimetro': double.parse(_perimetroController.text),
                });

                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Actualizar estadisticas'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: <Color>[Colors.orange[200]!, Colors.green[800]!]),
          ),
        ),
      ),
    );
  }
}
