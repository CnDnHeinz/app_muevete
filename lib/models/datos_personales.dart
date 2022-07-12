import 'package:app_muevete/models/academic.dart';
import 'package:app_muevete/models/persona.dart';
import 'package:flutter/foundation.dart';

class DatosPersonales {
  Persona inf_persona;
  List<Academic?> inf_alumno;

  DatosPersonales(this.inf_persona, this.inf_alumno);

  factory DatosPersonales.fromJson(Map<String, dynamic> json) =>
      new DatosPersonales(
        Persona.fromJson(json["datos"]["inf_persona"]),
        List<Academic>.from(
            json["datos"]["inf_alumno"].map((x) => Academic.fromJson(x))),
      );

  toJson() => {
        "inf_persona": inf_persona.toJson(),
        "inf_alumno": List<dynamic>.from(inf_alumno.map((x) => x?.toJson())),
      };
}
