import 'dart:convert';

import 'package:app_muevete/models/health_stats.dart';
import 'package:app_muevete/utils/app_env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StadisticsService {
<<<<<<< HEAD
  String url = "http://ws.unheval.edu.pe/api/v1/app_muevete";
=======
  String url = "${AppEnv.apiUrl}/api/v1/app_muevete";
>>>>>>> 7891c95a0528035048791916907732b54a080fa2
  Future<dynamic> submitStadistics(data) async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.post(Uri.parse(url + '/estadistica'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          //'Authorization': 'Bearer ' + prefs.getString('token')
        },
        body: jsonEncode(<String, dynamic>{
          'id_usuario': prefs.getInt('id_usuario'),
          'edad': data['edad'],
          'peso': data['peso'],
          'altura': data['estatura'],
          'perimetro': data['perimetro'],
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

  Future<HealthStats> getStadistics() async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.get(
        Uri.parse(
            url + '/estadistica/' + prefs.getInt('id_usuario').toString()),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          //'Authorization': 'Bearer ' + prefs.getString('token')
        });
    try {
      if (respuesta.statusCode == 200) {
        var _response = HealthStats.fromJson(jsonDecode(respuesta.body));
        //var _response = jsonDecode(respuesta.body); */
        //return respuesta.body;
        print(_response);
        return _response;
      } else {
        print(respuesta.body);
        throw Exception('Failed to save stadistics data');
      }
    } catch (e) {
      print(e);
      return Future<HealthStats>(() => throw Exception(e.toString()));
    }
  }

  Future<dynamic> loasStats() async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.get(
        Uri.parse(url +
            '/load-stats?id_usuario=' +
            prefs.getInt('id_usuario').toString()),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          //'Authorization': 'Bearer ' + prefs.getString('token')
        });
    try {
      if (respuesta.statusCode == 200) {
        var _response = jsonDecode(respuesta.body);
        //return respuesta.body;
        prefs.setDouble("imc", _response["imc"]);
        prefs.setInt("perimetro", _response["perimetro"]);
        prefs.setInt("nutricion", _response["nutricion"]);
        prefs.setInt("actividad_fisica", _response["actividad_fisica"]);
        prefs.setInt("habito", _response["habito"]["id"]);
        return _response;
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
