class Academic {
  String nivel;
  String escuela;
  String sit_alumno;

  Academic(this.nivel, this.escuela, this.sit_alumno);

  factory Academic.fromJson(Map<String, dynamic> json) => new Academic(
        json["nivel"],
        json["escuela"],
        json["sit_alum"],
      );

  toJson() => {
        "nivel": nivel,
        "escuela": escuela,
        "sit_alum": sit_alumno,
      };
}
