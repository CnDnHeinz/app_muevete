import 'package:app_muevete/models/health_stats.dart';
import 'package:app_muevete/services/stadistics_service.dart';
import 'package:app_muevete/utils/tema.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _weight = '0';
  String _IMC = '0';
  String _height = '0';
  String _perimeter = '0';
  String _phisyc_activite = '0';
  String _edad = '0';
  String _nutrition = '0';

  final _service = new StadisticsService();

  HealthStats? _healthStats;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadStats();
  }

  _loadStats() async {
    //HealthStats temp = await _service.getStadistics();

    setState(() {
      _IMC = '27.5';
      _nutrition = '21';
      _perimeter = '88cm';
      _phisyc_activite = '9';
    });
  }

  //boton de navegacion
  Widget _buttomAntion(IconData icon, [bool isActive = false]) {
    Color _btn_color = Colors.grey;
    if (isActive) {
      _btn_color = Tema().getColorPrimary();
    }

    return InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Icon(icon, color: _btn_color),
        ));
  }

  Widget _dataDisplay(String label, var valor, [String unidad = "Kg"]) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.white)),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "$valor",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TextSpan(text: unidad, style: TextStyle(fontSize: 10)),
        ]))
      ]),
    );
  }

  Widget _estadisticas() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        child: Column(children: [
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _dataDisplay("Minimo", _weight),
                  _dataDisplay("Promedio", _weight),
                  _dataDisplay("Maximo", _weight),
                ]),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _dataDisplay("Peso inicial", _weight),
                  _dataDisplay("Peso actual", _weight),
                ]),
          ),
        ]),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Tema().getColorPrimary(),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2)
            ]),
      ),
    );
  }

  // cuerpo de la pantalla
  Widget _body() {
    return SafeArea(
      child: Column(children: <Widget>[
        //_estadisticas(),
        //_grafico(),
        _home(),
      ]),
    );
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _weight = prefs.getDouble('actual_weigth').toString();
    });
  }

  Widget _opcion(String title, String valor, String desc, String path) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, path);
      },
      child: Container(
          height: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
              ),
              Text(
                valor,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: Colors.grey),
              )
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Colors.grey))),
    );
  }

  Widget _home() {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: GridView.count(
          scrollDirection: Axis.vertical,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            _opcion("IMC", _IMC, "SOBRE PESO", "imc"),
            _opcion("HABITOS NUTRICIONALES", _nutrition, "POCO SALUDABLE",
                "nutricion"),
            _opcion(
                "PERIMETRO ABDOMINAL", _perimeter, "RIESGO BAJO", "perimetro"),
            _opcion(
                "ACTIVIDAD FISICA", _phisyc_activite, "MODERADO", "actividad"),
            //_opcion(),
            //_opcion(),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buttomAntion(Icons.home_rounded, true),
            _buttomAntion(Icons.show_chart_rounded),
            _buttomAntion(Icons.history_rounded),
            _buttomAntion(Icons.favorite_rounded),
            _buttomAntion(Icons.settings_rounded),
          ],
        ),
      ),
      body: _body(),
    );
  }
}
