import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioService {
  UsuarioService();

  Future<dynamic> checkUsuarioInfo(String query) async {
    String url = "http://api-unheval.ale:88/api/v1/app_muevete/";
    final respuesta = await http.get(
      Uri.parse(url + 'usuario/info?' + query),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        //'Authorization': 'Bearer ' + prefs.getString('token')
      },
    );

    try {
      if (respuesta.statusCode == 200) {
        //print(respuesta.body);
        var _response = jsonDecode(respuesta.body);
        //print(_response);
        return _response;
      } else {
        print(respuesta.body);
        throw Exception('Failed to load personal data');
      }
    } catch (e) {
      print(e);
      return Future<dynamic>(() => throw Exception(e.toString()));
    }
  }
}
