import 'dart:ffi';

class HealthStats {
  int age;
  int height;
  double weight;
  double perimeter;

  HealthStats(this.age, this.height, this.weight, this.perimeter);

  factory HealthStats.fromJson(Map<String, dynamic> json) {
    return HealthStats(
      int.parse(json['edad']),
      int.parse(json['altura']),
      double.parse(json['peso']),
      double.parse(json['perimetro']),
    );
  }
}
