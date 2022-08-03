import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StadisticsService {
  String url = "http://ws.unheval.edu.pe/api/v1/app_muevete";
  Future<dynamic> submitStadistics(data) async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.post(Uri.parse(url + '/estadistica'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          //'Authorization': 'Bearer ' + prefs.getString('token')
        },
        body: jsonEncode(<String, dynamic>{
          'id_usuario' : prefs.getInt('id_usuario'),
          'edad' : data['edad'],
          'peso' : data['peso'],
          'altura' : data['estatura'],
          'perimetro' : data['perimetro'],
        }));
    try {
      if (respuesta.statusCode == 201) {
        //var _response = DatosPersonales.fromJson(jsonDecode(respuesta.body));
        /* var _response = jsonDecode(respuesta.body); */
        prefs.setBool('estadisticas', true);
        return respuesta.body;
      } else {
        print(respuesta.body);
        throw Exception('Failed to save stadistics data');
      }
    } catch (e) {
      print(e);
      return Future<dynamic>(() => throw Exception(e.toString()));
    }
  }
}
