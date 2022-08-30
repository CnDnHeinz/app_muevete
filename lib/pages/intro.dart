import 'package:app_muevete/components/app_button.dart';
import 'package:app_muevete/pages/encuesta_two.dart';
import 'package:app_muevete/pages/home.dart';
import 'package:app_muevete/pages/profile.dart';
import 'package:app_muevete/pages/stadistics.dart';
import 'package:app_muevete/pages/welcome.dart';
import 'package:app_muevete/services/usuario_service.dart';
import 'package:app_muevete/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final _userService = UsuarioService();
  final String imagePath = "assets/img/fondo_app.jpg";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    Widget _slogan() {
      return Container(
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
                    color: Colors.grey[100],
                  ),
                  children: [
                    TextSpan(
                      text: '"Come sano y muevete"',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
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
                      color: Colors.grey[100]),
                  children: [
                    TextSpan(
                      text: ' alimentación saludable y actividad física ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    TextSpan(
                      text: 'de los estudiantes de la UNHEVAL de Huánuco"',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[100],
                      ),
                    ),
                  ]),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: const Image(
                  image: AssetImage('assets/img/logo-app.png'),
                  width: 200,
                ),                
              ),
              _slogan(),
              const SizedBox(
                height: 40.0,
              ),
              AppButton(
                label: "Continuar",
                fontWeight: FontWeight.w600,
                padding: const EdgeInsets.symmetric(vertical: 25),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();

                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      if (prefs.getInt('id_usuario') == null) {
                        return const Profile();
                      } else if (prefs.getBool('estadisticas') == null) {
                        return const Stadistcs();
                      } else if (prefs.getBool('encuesta1') == null) {
                        return const Welcome();
                      } else if (prefs.getBool('encuesta2') == null) {
                        return const EncuestaTwo();
                      } else {
                        //return const Stadistcs();
                        return const Home();
                      }
                    }),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
