import 'dart:convert';

import 'package:app_muevete/models/exercise.dart';
import 'package:app_muevete/utils/app_env.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExersiceService {
  String url = "${AppEnv.apiUrl}/api/v1/app_muevete";

  List<Exercise> getEjersiciosPrimerNivel() {
    return [
      new Exercise(
          1,
          "SENTADILLA EN LA PARED",
          "Apoyar la espalda y la cabeza a la pared, separar los pies y bajar el cuerpo. Las rodillas y cadera deben formar un ángulo recto; muslos deben estar paralelos al piso",
          "1",
          'activ_fisica_lvl1_1.png',
          "",
          "",
          "",
          "1",
          "1",
          "Alex"),
      new Exercise(
          2,
          "INCLINACIONES LATERALESDE TRONCO",
          "De pie, con piernas separadas a la altura de las caderas. Inclinarse al lado derecho de manera alternativa con brazos paralelos al cuerpo, apretando la zona. Realice el movimiento de manera alternada. ",
          "2",
          'activ_fisica_lvl1_2.png',
          "",
          "",
          "",
          "2",
          "1",
          "Alex"),
      new Exercise(
          3,
          "PUENTE DE GLÚTEOS",
          "En posición supina con la espalda completamente estirada y rodillas flexionadas, con los pies a la línea de la cadera, brazos extendidos con la palma al piso. Elevar la cadera, apretando los glúteos por 1 a 2 seg, manteniendo la espalda y glúteos rectos.",
          "15",
          'activ_fisica_lvl1_3.png',
          "",
          "",
          "",
          "3",
          "1",
          "Alex"),
      new Exercise(
          4,
          "PANTORRILLAS",
          "Pararse recto con el apoyo de una silla (o en la pared), piernas ligeramente separadas, puntas de pie al frente. Con ambos pies, elevar los talones y bajarlos de manera lenta y continua.",
          "15",
          'activ_fisica_lvl1_4.png',
          "",
          "",
          "",
          "4",
          "1",
          "Alex"),
      new Exercise(
          5,
          "JUMPING JACKS",
          "Piernas levemente separadas y brazos paralelos al piso, saltar separando las piernas y llevando los brazos completamente estirados sobre la cabeza (juntar las palmas), saltar otra vez y llegar a la posición inicial. Realizar el ejercicio de manera continua.",
          "15",
          'activ_fisica_lvl1_5.png',
          "",
          "",
          "",
          "5",
          "1",
          "Alex"),
      new Exercise(
          6,
          "PATADA AL FRENTE",
          "Piernas levemente separadas, elevar cada una de ellas de manera intercalada hacia el frente de la persona, de manera recta. Tratar de tocar con la mano contraria la punta del pie elevado.",
          "15",
          'activ_fisica_lvl1_6.png',
          "",
          "",
          "",
          "6",
          "1",
          "Alex"),
      new Exercise(
          7,
          "ABDOMINALES DE PIE",
          "Espalda recta, colocar las manos detrás de la cabeza. Flexiona levemente las rodillas elevándola hacia el abdomen, tratando que la rodilla toque el codo contrario (pierna izquierda, hacia el codo derecho y viceversa). Conservar siempre la espalda recta",
          "15",
          'activ_fisica_lvl1_7.png',
          "",
          "",
          "",
          "7",
          "1",
          "Alex"),
      new Exercise(
          8,
          "DORSALES",
          "Acostarse en posición prono (boca abajo) completamente estirado. Brazos estirados hacia delante y dedos de los pies estirados hacia fuera. Elevar las piernas y brazos en simultáneo a la misma altura, sin dejar caer al piso.",
          "15",
          'activ_fisica_lvl1_8.png',
          "",
          "",
          "",
          "8",
          "1",
          "Alex"),
    ];
  }

  Future<List<Exercise>> getEjercicios() async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.get(
      Uri.parse(
          '$url/ejercicios/show?id_usuario=${prefs.getInt("id_usuario").toString()}'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        //'Authorization': 'Bearer ' + prefs.getString('token')
      },
    );

    try {
      if (respuesta.statusCode == 200) {
        //print(respuesta.body);
        var resp = jsonDecode(respuesta.body);
        //print(resp);
        return List<Exercise>.from(resp.map((x) => Exercise.fromJson(x)));
      } else {
        //print(respuesta.body);
        throw Exception('Failed to load exercice data');
      }
    } catch (e) {
      print(e);
      return Future<List<Exercise>>(() => throw Exception(e.toString()));
    }
  }

  Future<dynamic> storeExercises(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(url + '/ejercicios/store'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        //'Authorization': 'Bearer ' + prefs.getString('token')
      },
      body: jsonEncode(<String, dynamic>{
        'id_usuario': prefs.getInt('id_usuario'),
        'ejercicio': {
          'id': data["id"],
          'descripcion': data["descripcion"],
          'duracion': data["duracion"],
          'completed': data["completed"]
        }
      }),
    );
    try {
      if (response.statusCode == 201) {
        //var _response = DatosPersonales.fromJson(jsonDecode(respuesta.body));
        return response.body;
      } else {
        print(response.body);
        throw Exception('Failed to save eats data');
      }
    } catch (e) {
      print(e);
      return Future<dynamic>(() => throw Exception(e.toString()));
    }
  }
}
