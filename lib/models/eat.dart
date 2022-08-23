class Eat {
  int id;
  String descripcion;
  bool selected;

  Eat(this.id, this.descripcion, [this.selected = false]);

  factory Eat.fromJson(Map<String, dynamic> json) =>
      Eat(json["id"], json["descripcion"], json["selected"]);
}
