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

  @override
  void initState() {
    super.initState();
    _loadPreferences();
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
        _estadisticas(),
        //_grafico(),
      ]),
    );
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _weight = prefs.getDouble('actual_weigth').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buttomAntion(Icons.person_rounded),
            _buttomAntion(Icons.show_chart_rounded, true),
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
