import 'dart:async';
import 'dart:convert';
import 'package:app_muevete/utils/app_env.dart';
import 'package:http/http.dart' as http;
import 'package:app_muevete/models/datos_personales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatosPersonalesService {
  String url = "${AppEnv.apiUrl}/api/v1/informacion-persona";
  String url2 = "${AppEnv.apiUrl}/api/v1/app_muevete/usuario";
  // Constructor
  DatosPersonalesService();

  Future<DatosPersonales> getDatosPersonales(String codigo) async {
    final respuesta = await http.get(Uri.parse(url +
        '?dni=' +
        (codigo == null || codigo == '' ? '00000000' : codigo)));
    //print(respuesta.body);
    try {
      if (respuesta.statusCode == 200) {
        //print(respuesta.body);
        var _response = DatosPersonales.fromJson(jsonDecode(respuesta.body));

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('codigo', _response.inf_persona.codigo);
        prefs.setString('nombres', _response.inf_persona.nombres);
        prefs.setString('paterno', _response.inf_persona.paterno);
        prefs.setString('materno', _response.inf_persona.materno);
        prefs.setString('dni', _response.inf_persona.dni);
        prefs.setString('email', _response.inf_persona.email);
        prefs.setString('telefono', _response.inf_persona.telefono);
        prefs.setString('id_sexo', _response.inf_persona.id_sexo);

        return _response;
      } else {
        throw Exception('Failed to load personal data');
      }
    } catch (e) {
      print(e);
      return Future<DatosPersonales>(() => throw Exception(e.toString()));
    }
  }

  Future<dynamic> storeDatosPersonales(DatosPersonales? datos) async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.post(Uri.parse(url2),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          //'Authorization': 'Bearer ' + prefs.getString('token')
        },
        body: jsonEncode(datos?.toJson()));
    try {
      if (respuesta.statusCode == 201) {
        //var _response = DatosPersonales.fromJson(jsonDecode(respuesta.body));
        var _response = jsonDecode(respuesta.body);
        prefs.setInt('id_usuario', _response['id']);
        return respuesta.body;
      } else {
        print(respuesta.body);
        throw Exception('Failed to save personal data');
      }
    } catch (e) {
      print(e);
      return Future<DatosPersonales>(() => throw Exception(e.toString()));
    }
  }
}
