import 'dart:convert';

import 'package:app_muevete/models/eat.dart';
import 'package:app_muevete/models/habit.dart';
import 'package:app_muevete/models/meal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MealService {
  String url = "http://api-unheval.ale:88/api/v1/app_muevete";

  MealService();

  static List<Meal> meals = [
    new Meal(
      1,
      "Desayuno",
      [
        new Eat(1, "Frutas picadas con y almendras"),
        new Eat(2, "Milo con leche evaporada descremada (bajo en azúcar)"),
        new Eat(3, "Quinua con maca"),
        new Eat(4, "Pan con aceituna"),
        new Eat(5, "Pan con queso descremado")
      ],
    ),
    new Meal(
      2,
      "Media mañana",
      [
        new Eat(1, "Emoliente"),
        new Eat(2, "Tortilla de verduras"),
        new Eat(3, "Mandarina"),
      ],
    ),
    new Meal(
      3,
      "Almuerzo",
      [
        new Eat(1, "Ensalada de mixta con papa y palta"),
        new Eat(2, "Sopa de ollucos"),
        new Eat(3, "Pescado al horno en salsa de alcachofa"),
        new Eat(4, "Arroz con jengibre"),
        new Eat(5, "Tajada de piña"),
        new Eat(6, "Refresco de maracuyá con germinado de quinua")
      ],
    ),
    new Meal(
      4,
      "Media tarde",
      [
        new Eat(1, "Chicha morada"),
        new Eat(2, "Tostadas con queso"),
      ],
    ),
    new Meal(
      5,
      "Cena",
      [
        new Eat(1, "Ensalada de vainitas, choclo y queso"),
        new Eat(2, "Crema de espinaca"),
        new Eat(3, "Pollo al curry con papas gratinadas"),
        new Eat(4, "Durazno"),
        new Eat(5, "Agua de manzana")
      ],
    ),
    new Meal(
      6,
      "Recomendaciones",
      [],
    )
  ];

  Future<List<Meal>> getMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final respuesta = await http.get(
      Uri.parse(url +
          '/comidas/show?habito=' +
          (prefs.getInt("habito") ?? 0).toString() +
          '&id_usuario=' +
          prefs.getInt("id_usuario").toString()),
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
