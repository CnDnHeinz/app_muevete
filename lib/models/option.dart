class Option {
  int id;
  String label;
  String value;
  bool selected;
  Option(this.id, this.label, this.value, this.selected);

  factory Option.fromJson(Map<String, dynamic> json) =>
      Option(json["id"], json["label"], json["value"], json["selected"]);

  toJson() => {
        "id": id,
        "label": label,
        "value": value,
        "selected": selected,
      };
}
