import 'dart:convert';

import 'package:app_muevete/utils/app_env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QuestionaryService {
<<<<<<< HEAD
  String url = "http://ws.unheval.edu.pe/api/v1/app_muevete";
=======
  String url = "${AppEnv.apiUrl}/api/v1/app_muevete";
>>>>>>> 7891c95a0528035048791916907732b54a080fa2

  QuestionaryService();
  Future<dynamic> submitResponses(data, id_enc) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$url/encuesta/${id_enc.toString()}'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        //'Authorization': 'Bearer ' + prefs.getString('token')
      },
      body: jsonEncode(<String, dynamic>{
        'id_usuario': prefs.getInt('id_usuario'),
        'respuestas': data
      }),
    );
    try {
      if (response.statusCode == 201) {
        //var _response = DatosPersonales.fromJson(jsonDecode(respuesta.body));

        var _response = jsonDecode(response.body);
        print(_response);
        if (id_enc == 1) {
          prefs.setBool('encuesta1', true);
        } else if (id_enc == 2) {
          prefs.setBool('encuesta2', true);
        }
        return response.body;
      } else {
        print(response.body);
        throw Exception('Failed to save responses data');
      }
    } catch (e) {
      print(e);
      return Future<dynamic>(() => throw Exception(e.toString()));
    }
  }
}
