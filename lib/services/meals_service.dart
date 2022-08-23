import 'package:app_muevete/models/eat.dart';
import 'package:app_muevete/models/habit.dart';
import 'package:app_muevete/models/meal.dart';

class MealService {
  MealService();

  static List<Meal> meals = [
    new Meal(
      1,
      "Desayuno",
      [
        new Eat(1, "Frutas picadas con y almendras"),
        new Eat(2, "Milo con leche evaporada descremada (bajo en azúcar)"),
        new Eat(3, "Quinua con maca"),
        new Eat(4, "Pan con aceituna"),
        new Eat(5, "Pan con queso descremado")
      ],
      new Habit(
          5, "Hábitos alimentarios poco saludables / Moderadamente activo"),
    ),
    new Meal(
      2,
      "Media mañana",
      [
        new Eat(1, "Emoliente"),
        new Eat(2, "Tortilla de verduras"),
        new Eat(3, "Mandarina"),
      ],
      new Habit(
          5, "Hábitos alimentarios poco saludables / Moderadamente activo"),
    ),
    new Meal(
      3,
      "Almuerzo",
      [
        new Eat(1, "Ensalada de mixta con papa y palta"),
        new Eat(2, "Sopa de ollucos"),
        new Eat(3, "Pescado al horno en salsa de alcachofa"),
        new Eat(4, "Arroz con jengibre"),
        new Eat(5, "Tajada de piña"),
        new Eat(6, "Refresco de maracuyá con germinado de quinua")
      ],
      new Habit(
          5, "Hábitos alimentarios poco saludables / Moderadamente activo"),
    ),
    new Meal(
      4,
      "Media tarde",
      [
        new Eat(1, "Chicha morada"),
        new Eat(2, "Tostadas con queso"),
      ],
      new Habit(
          5, "Hábitos alimentarios poco saludables / Moderadamente activo"),
    ),
    new Meal(
      5,
      "Cena",
      [
        new Eat(1, "Ensalada de vainitas, choclo y queso"),
        new Eat(2, "Crema de espinaca"),
        new Eat(3, "Pollo al curry con papas gratinadas"),
        new Eat(4, "Durazno"),
        new Eat(5, "Agua de manzana")
      ],
      new Habit(
          5, "Hábitos alimentarios poco saludables / Moderadamente activo"),
    ),
    new Meal(
      6,
      "Recomendaciones",
      [],
      new Habit(
          5, "Hábitos alimentarios poco saludables / Moderadamente activo"),
    )
  ];
}
