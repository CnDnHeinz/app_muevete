import 'package:app_muevete/models/eat.dart';

class Meal {
  int id;
  String descripcion;
  List<Eat> platos;
  bool? isOpen;

  Meal(this.id, this.descripcion, this.platos, [this.isOpen = false]);

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        json["id"],
        json["descripcion"],
        List<Eat>.from(json["platos"]
            .map((x) => Eat(x['id'], x['descripcion'], x["selected"]))),
        false,
      );

  toJson() => {
        "id": id,
        "descripcion": descripcion,
        "platos": platos.map((e) => e.toJson()).toList(),
        "isOpen": isOpen,
      };
}
