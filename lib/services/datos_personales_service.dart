import 'dart:async';
import 'dart:convert';
import 'package:app_muevete/models/academic.dart';
import 'package:app_muevete/models/persona.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:app_muevete/models/datos_personales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatosPersonalesService {
  String url = "http://ws.unheval.edu.pe/api/v1/informacion-persona";
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
}
