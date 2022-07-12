class Persona {
  String codigo;
  String dni;
  String paterno;
  String materno;
  String nombres;
  String email;
  String telefono;
  String id_sexo;

  Persona(
    this.codigo,
    this.dni,
    this.paterno,
    this.materno,
    this.nombres,
    this.email,
    this.telefono,
    this.id_sexo,
  );

  factory Persona.fromJson(Map<String, dynamic> json) => new Persona(
        json["Codigo"] ?? '',
        json["DNI"] ?? '',
        json["Paterno"] ?? '',
        json["Materno"] ?? '',
        json["Nombres"] ?? '',
        json["E_Mail"] ?? '',
        json["Telefono"] ?? '',
        json["Id_Sexo"] ?? '',
      );

  toJson() => {
        "Codigo": codigo,
        "DNI": dni,
        "Paterno": paterno,
        "Materno": materno,
        "Nombres": nombres,
        "E_Mail": email,
        "Telefono": telefono,
        "Id_Sexo": id_sexo,
      };
}
