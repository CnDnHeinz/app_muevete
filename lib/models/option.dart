class Option {
  int id;
  String label;
  String value;
  bool selected;
  Option(this.id, this.label, this.value, this.selected);

  toJson() => {
        "id": id,
        "label": label,
        "value": value,
        "selected": selected,
      };
}
