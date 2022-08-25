import 'package:app_muevete/models/eat.dart';
import 'package:app_muevete/models/habit.dart';

class Meal {
  int id;
  String descripcion;
  List<Eat> platos;

  Meal(this.id, this.descripcion, this.platos);

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
      json["id"],
      json["descripcion"],
      List<Eat>.from(json["platos"]
          .map((x) => Eat(x['id'], x['descripcion'], x["selected"]))));

  toJson() => {
        "id": id,
        "descripcion": descripcion,
        "platos": platos,
      };
}
