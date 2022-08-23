import 'package:app_muevete/models/eat.dart';
import 'package:app_muevete/models/habit.dart';

class Meal {
  int id;
  String descripcion;
  List<Eat> comidas;
  Habit habito;

  Meal(this.id, this.descripcion, this.comidas, this.habito);

  factory Meal.fromJson(Map<String, dynamic> json) =>
      Meal(json["id"], json["descripcion"], json["comidas"], json["habito"]);

  toJson() => {
        "id": id,
        "descripcion": descripcion,
        "comidas": comidas,
        "habito": habito
      };
}
