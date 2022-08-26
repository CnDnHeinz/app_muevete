import 'dart:convert';

import 'package:app_muevete/models/eat.dart';
import 'package:app_muevete/models/meal.dart';
import 'package:app_muevete/utils/app_env.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MealService {
  String url = "${AppEnv.apiUrl}/api/v1/app_muevete";

  MealService();

  Future<List<Meal>> getMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.get(
      Uri.parse(
          '$url/comidas/show?habito=${(prefs.getInt("habito") ?? 0).toString()}&id_usuario=${prefs.getInt("id_usuario").toString()}'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        //'Authorization': 'Bearer ' + prefs.getString('token')
      },
    );

    try {
      if (respuesta.statusCode == 200) {
        //print(respuesta.body);
        var resp = jsonDecode(respuesta.body);
        print(resp);
        return List<Meal>.from(resp.map((x) => Meal.fromJson(x)));
      } else {
        print(respuesta.body);
        throw Exception('Failed to load personal data');
      }
    } catch (e) {
      print(e);
      return Future<List<Meal>>(() => throw Exception(e.toString()));
    }
  }

  Future<dynamic> storeEats(Eat comida) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(url + '/comidas/store'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        //'Authorization': 'Bearer ' + prefs.getString('token')
      },
      body: jsonEncode(<String, dynamic>{
        'id_usuario': prefs.getInt('id_usuario'),
        'comida': {
          'id': comida.id,
          'descripcion': comida.descripcion,
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
