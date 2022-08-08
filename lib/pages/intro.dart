import 'package:app_muevete/pages/encuesta_two.dart';
import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/pages/profile.dart';
import 'package:app_muevete/pages/stadistics.dart';
import 'package:app_muevete/pages/welcome.dart';
import 'package:app_muevete/services/usuario_service.dart';
import 'package:app_muevete/utils/tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final _userService = UsuarioService();

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  _getUserInfo() async {
    var temp = await _userService.checkUsuarioInfo('id=2');
    print(temp);
  }

  @override
  Widget build(BuildContext context) {
    Widget _btnContinuar(String text) {
      return ElevatedButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              if (prefs.getInt('id_usuario') == null) {
                return Profile();
              } else if (prefs.getBool('estadisticas') == null) {
                return Stadistcs();
              } else if (prefs.getBool('encuesta1') == null) {
                return Welcome();
              } else if (prefs.getBool('encuesta2') == null) {
                return EncuestaTwo();
              } else {
                return Home();
              }
            }),
          );
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

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: <Widget>[
            Container(
              height: 80,
            ),
            Container(
              child: const Image(
                image: AssetImage('assets/img/logo-app.png'),
                width: 200,
              ),
              padding: const EdgeInsets.symmetric(vertical: 40),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RichText(
                      text: TextSpan(
                        text: 'Programa: ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        children: [
                          TextSpan(
                            text: '"Come sano y muevete"',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Tema().getColorPrimary(),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: '"Para promover la',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800]),
                        children: [
                          TextSpan(
                            text: ' alimentacion saludable y actividad física ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Tema().getColorPrimary(),
                            ),
                          ),
                          TextSpan(
                            text:
                                'de los estudiantes de la UNHEVAL de Huánuco"',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                            ),
                          ),
                        ]),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _btnContinuar('Continuar'),
                ),
              )),
            )
          ]),
        ),
      ),
    );
  }
}
