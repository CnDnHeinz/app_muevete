class Habit {
  int id;
  String descripcion;
  Habit(this.id, this.descripcion);

  factory Habit.fromJson(Map<String, dynamic> json) =>
      Habit(json["id"], "descripcion");
}
