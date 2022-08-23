import 'package:app_muevete/models/option.dart';

class Question {
  int id;
  String question;
  List<Option> options;
  bool multiple;
  Question(this.id, this.question, this.options, this.multiple);

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      json["id"],
      json["question"],
      List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      json["multiple"]);

  toJson() => {
        "id": id,
        "question": question,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "multiple": multiple,
      };
}
