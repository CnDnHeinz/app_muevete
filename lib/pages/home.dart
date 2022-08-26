import 'package:app_muevete/components/app_nab_bar.dart';
import 'package:app_muevete/models/app_nav_option.dart';
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
  final _service = new StadisticsService();

  Future<String> getUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString('nombres') ?? '') +
        ', ' +
        (prefs.getString("paterno") ?? '');
  }

  Widget _header() {
    return FutureBuilder<String>(
        future: getUsuario(),
        builder: (constext, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.location_history),
              const SizedBox(
                width: 8,
              ),
              Text(
                snapshot.data ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        });
  }

  Widget _body() {
    final builder = FutureBuilder<dynamic>(
      future: _service.loasStats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return GridView.count(
            scrollDirection: Axis.vertical,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: [
              _opcion(
                "IMC",
                snapshot.data["imc"].toString(),
                snapshot.data["diagnostico"]['imc'],
                "imc",
                snapshot.data['diagnostico']['imc_color'],
              ),
              _opcion(
                "HABITOS NUTRICIONALES",
                snapshot.data["nutricion"].toString(),
                snapshot.data["diagnostico"]['nutricion'],
                "nutricion",
                snapshot.data['diagnostico']['nutricion_color'],
              ),
              _opcion(
                "PERIMETRO ABDOMINAL",
                snapshot.data["perimetro"].toString(),
                snapshot.data["diagnostico"]['perimetro'],
                "perimetro",
                snapshot.data['diagnostico']['perimetro_color'],
              ),
              _opcion(
                "ACTIVIDAD FISICA",
                snapshot.data["actividad_fisica"].toString(),
                snapshot.data["diagnostico"]['actividad_fisica'],
                "actividad",
                snapshot.data['diagnostico']['actividad_fisica_color'],
              ),
            ],
          );
        }
        return const Center(
          child: Text('Servidor no está disponible'),
        );
      },
    );

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        const SizedBox(height: 20.0),
        _header(),
        const SizedBox(height: 20.0),
        builder
      ],
    );
  }

  Widget _opcion(String title, String valor, String desc, String path,
      [String variante = "normal"]) {
    Color colorText = Colors.blue;
    Color colorBorder = Colors.blueAccent;
    Color colorBg = Colors.blue[50]!;
    if (variante == "danger") {
      colorText = Colors.red;
      colorBorder = Colors.redAccent;
      colorBg = Colors.red[50]!;
    } else if (variante == "warning") {
      colorText = Colors.orange;
      colorBorder = Colors.orangeAccent;
      colorBg = Colors.orange[50]!;
    } else if (variante == "success") {
      colorText = Colors.green;
      colorBorder = Colors.greenAccent;
      colorBg = Colors.green[50]!;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, path);
      },
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorBg,
          border: Border.all(
            color: colorBorder,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorText,
              ),
            ),
            Text(
              valor,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: colorText,
              ),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w200,
                color: colorText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: AppNavBar(
          items: navigatorItems,
        ),
      ),
    );
  }
}
