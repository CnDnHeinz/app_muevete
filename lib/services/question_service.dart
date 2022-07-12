import 'package:app_muevete/models/option.dart';
import 'package:app_muevete/models/question.dart';

class QuestionService {
  /* Future<List<Question>> getQuestions() async {
    return await _questionRepository.getQuestions();
  } */

  List<Question> getAllQuestions() {
    return [
      Question(
          1,
          "1. ¿Usted es beneficiario del comedor universitario en la UNHEVAL?",
          [
            Option(1, "Si", "yes", false),
            Option(2, "No", "no", false),
          ],
          false),
      Question(
          2,
          "2. ¿Cómo consideras tu estado de salud en este momento?",
          [
            Option(1, "Muy bien", "verygood", false),
            Option(2, "Bien", "good", false),
            Option(3, "Regular", "normal", false),
            Option(4, "Mal", "bad", false),
          ],
          false),
      Question(
          3,
          "3. ¿Te preocupa tu peso?",
          [
            Option(1, "Si", "yes", false),
            Option(2, "No", "no", false),
          ],
          false),
      Question(
          4,
          "4. Con qué frecuencia practicas ejercicio físico a la semana?",
          [
            Option(1, "Nunca", "never", false),
            Option(2, "Una vez", "one time", false),
            Option(3, "2 veces", "two times", false),
            Option(4, "3 veces", "three times", false),
            Option(5, "De 4 a 5 veces", "More than four times", false),
          ],
          false),
      Question(
          5,
          "5. ¿Qué tipo de deporte practicas con mayor frecuencia? Actividad física practicas…",
          [
            Option(1, "Futbol", "soccer", false),
            Option(2, "Vóley", "volley", false),
            Option(3, "Basquet", "basketball", false),
            Option(4, "Baile o danza", "dance", false),
            Option(5, "Caminatas", "walk", false),
            Option(6, "Ciclismo", "cycling", false),
            Option(7, "Natación", "swimming", false),
            Option(8, "Otro", "other", false),
          ],
          true),
      Question(
          6,
          "6. Tu dificultad para realizar ejercicios físicos es…",
          [
            Option(1, "Por falta de tiempo.", "", false),
            Option(2, "Por falta de voluntad.", "", false),
            Option(3, "Por motivos económicos.", "", false),
            Option(
                4,
                "Porque los horarios de estudio o trabajo no me permiten.",
                "",
                false),
            Option(5, "Por problemas de salud.", "", false),
            Option(
                6,
                "No tengo ninguna dificultad para hacer ejercicios físicos.",
                "",
                false),
          ],
          true),
      Question(
          7,
          "7. ¿Cómo es tu actividad física desde que ingresaste a la universidad?",
          [
            Option(1, "Dejé de hacer ejercicio físico.", "", false),
            Option(2, "Hago ejercicio físico con menos frecuencia.", "", false),
            Option(
                3, "Hago los mismos ejercicios físicos de siempre.", "", false),
            Option(4, "Empecé a hacer ejercicio físico.", "", false),
            Option(5, "Hago más ejercicio físico que antes.", "", false),
          ],
          false),
      Question(
          8,
          "8. Durante las últimas semanas, ¿En cuántos días caminó por lo menos 10 minutos seguidos?",
          [
            Option(1, "Ningún día", "", false),
            Option(2, "Uno a dos días", "", false),
            Option(3, "Tres a cuatro días", "", false),
            Option(4, "Cinco a seis días", "", false),
            Option(5, "Todos los días", "", false),
          ],
          false),
      Question(
          9,
          "9. Habitualmente, ¿cuánto tiempo en total dedica a caminar a diario?",
          [
            Option(1, "Menos de 30 min.", "", false),
            Option(2, "30 a 60 min.", "", false),
            Option(3, "60 a 90 min.", "", false),
            Option(4, "90 a 120 min.", "", false),
            Option(5, "Más de 120 min.", "", false),
          ],
          false),
      Question(
          10,
          "10. Durante las últimas semanas, ¿cuánto tiempo pasó sentado(a) durante un día hábil?",
          [
            Option(1, "Menos de 1 hora ", "", false),
            Option(2, "1 a 3 horas", "", false),
            Option(3, "3 a 5 horas", "", false),
            Option(4, "5 a 7 horas", "", false),
            Option(5, "Más de 7 horas", "", false),
          ],
          false),
      Question(
          11,
          "11. ¿Realizas actividades físicas moderadas por lo menos 30 minutos diarios?",
          [
            Option(1, "Si", "", false),
            Option(2, "No", "", false),
          ],
          false),
      Question(
          12,
          "12. ¿Cuántos días a la semana realiza actividad física moderada por lo menos 30 minutos?",
          [
            Option(1, "Un día a la semana", "", false),
            Option(2, "De dos a tres días por semana", "", false),
            Option(3, "De cuatro a cinco días por semana", "", false),
            Option(4, "Todos los días de la semana.", "", false),
          ],
          false),
      Question(
          13,
          "13. Habitualmente ¿Cuánto tiempo dedica a realizar esa actividad física moderada?",
          [
            Option(1, "30 a 60 min.", "", false),
            Option(2, "60 a 90 min.", "", false),
            Option(3, "90 a 120 min.", "", false),
            Option(4, "Más de 120 min.", "", false),
          ],
          false),
      Question(
          14,
          "14. ¿Realizas actividades físicas intensas por lo menos 45 minutos diarios?",
          [
            Option(1, "Si", "", false),
            Option(2, "No", "", false),
          ],
          false),
      Question(
          15,
          "15. ¿Cuántos días a la semana realiza actividad física intensa por lo menos 45 minutos?",
          [
            Option(1, "Un día a la semana", "", false),
            Option(2, "De dos a tres días por semana", "", false),
            Option(3, "De cuatro a cinco días por semana", "", false),
            Option(4, "Todos los días de la semana.", "", false),
          ],
          false),
      Question(
          16,
          "16. Habitualmente ¿Cuánto tiempo dedica a realizar esa actividad física intensa?",
          [
            Option(1, "45 a 90 min.", "", false),
            Option(2, "90 a 120 min.", "", false),
            Option(3, "Más de 120 min.", "", false),
          ],
          false),
      Question(
          17,
          "17. ¿Disfrutas al realizar actividad física?",
          [
            Option(1, "Siempre", "", false),
            Option(2, "Casi siempre", "", false),
            Option(3, "Algunas veces", "", false),
            Option(4, "Nunca", "", false),
          ],
          false),
      Question(
          18,
          "18. ¿Qué tipo de ejercicios realizas por semana?",
          [
            Option(
                1,
                "Ejercicios de fuerza (pesas, ejercicios con propio peso)",
                "",
                false),
            Option(2, "Ejercicios aeróbicos (caminar, correr, algún deporte)",
                "", false),
            Option(3, "Combinado", "", false),
          ],
          false),
      Question(
          19,
          "19. ¿Recibes o recibías asesoramiento de parte un entrenador, instructor, docente de Educación Física en tus entrenamientos o rutinas? ",
          [
            Option(1, "Siempre", "", false),
            Option(2, "Casi siempre.", "", false),
            Option(3, "Algunas veces", "", false),
            Option(4, "Nunca", "", false),
          ],
          false),
    ];
  }

  List<Question> getQuestionsNutricion() {
    return [
      Question(
          1,
          "1.	Actualmente, ¿sigues alguna dieta de adelgazamiento?",
          [
            Option(1, "Si", "", false),
            Option(2, "No", "", false),
          ],
          false),
      Question(
          2,
          "2.	¿Cuántas veces durante el día consume alimentos?",
          [
            Option(1, "Menos de 3 veces al día", "", false),
            Option(2, "3 veces al dia", "", false),
            Option(3, "4 veces al dia", "", false),
            Option(4, "5 veces al dia", "", false),
            Option(5, "Más de 5 veces al dia", "", false),
          ],
          false),
      Question(
          3,
          "3.	¿Cuántas veces a la semana toma desayuno? ",
          [
            Option(1, "Nunca", "", false),
            Option(2, "1 - 2 veces a la semana", "", false),
            Option(3, "3 - 4 veces a la semana", "", false),
            Option(4, "5 - 6 veces a la semana", "", false),
            Option(5, "Diario", "", false),
          ],
          false),
      Question(
          4,
          "4. ¿Donde consume su desayono?",
          [
            Option(1, "En casa", "", false),
            Option(2, "En el comedor universitario", "", false),
            Option(3, "En un restaurante", "", false),
            Option(4, "En un restaurante", "", false),
            Option(5, "En los Puestos de ambulantes", "", false),
          ],
          false),
      Question(
          5,
          "5. ¿Con quién consume su desayuno?",
          [
            Option(1, "Con mi familia", "", false),
            Option(2, "Con mis amigos", "", false),
            Option(3, "Con mis compañeros de estudio.", "", false),
            Option(4, "Con mis compañeros de trabajo", "", false),
            Option(5, "Solo", "", false),
          ],
          false),
      Question(
          6,
          "6. ¿Cuál es el desayuno que consume con mayor frecuencia en el desayuno?",
          [
            Option(1, "Leche y/o yogurt + pan", "", false),
            Option(2, "Solo jugo de frutas", "", false),
            Option(3, "Cereales (avena, quinua, soya, maca) + pan", "", false),
            Option(4, "Infusiones o cafe + pan", "", false),
            Option(5, "Segundos o caldos", "", false),
            Option(6, "Otro", "", false),
          ],
          false),
      Question(
          7,
          "7. ¿Consume pan diariamente?",
          [
            Option(1, "Si", "", false),
            Option(2, "No", "", false),
            Option(3, "A veces", "", false),
          ],
          false),
      Question(
          8,
          "8. ¿Qué es lo que acostumbra a consumir en media mañana con mayor frecuencia?",
          [
            Option(1, "Snacks y/o galletas", "", false),
            Option(2, "Hamburguesa", "", false),
            Option(3, "Alguna golosina", "", false),
            Option(4, "Frutas", "", false),
            Option(5, "Nada", "", false),
          ],
          false),
      Question(
          9,
          "9. ¿Qué es lo que acostumbra a consumir en media tarde, con mayor frecuencia?",
          [
            Option(1, "Snacks y/o galletas", "", false),
            Option(2, "Hamburguesa", "", false),
            Option(3, "Alguna golosina", "", false),
            Option(4, "Frutas", "", false),
            Option(5, "Nada", "", false),
          ],
          false),
      Question(
          10,
          "10. ¿Qué bebidas suele consumir durante el día, con mayor frecuencia?",
          [
            Option(1, "Gaseosas", "", false),
            Option(2, "Refrescos", "", false),
            Option(3, "Infusiones", "", false),
            Option(4, "Agua natural", "", false),
            Option(5, "Jugos industrializados", "", false),
            Option(6, "Bebidas rehidratantes", "", false),
          ],
          false),
      Question(
          11,
          "11. ¿Cuántas veces a la semana suele almorzar?",
          [
            Option(1, "Nunca", "", false),
            Option(2, "1‐2 Veces a la semana", "", false),
            Option(3, "3‐4 Veces a la semana", "", false),
            Option(4, "5‐6 veces a la semana ", "", false),
            Option(5, "Diario", "", false),
          ],
          false),
      Question(
          12,
          "12. ¿Dónde consume su almuerzo?",
          [
            Option(1, "En casa", "", false),
            Option(2, "En el comedor universitario", "", false),
            Option(3, "En un restaurante", "", false),
            Option(4, "En un restaurante", "", false),
            Option(5, "En los Puestos de ambulantes", "", false),
          ],
          false),
      Question(
          13,
          "13. ¿Qué suele consumir mayormente en su almuerzo?",
          [
            Option(1, "Comida Criolla ", "", false),
            Option(2, "Comida Vegetariana ", "", false),
            Option(3, "Comida Light", "", false),
            Option(4, "Pollo a la brasa y / o Pizzas", "", false),
            Option(5, "Comida Chatarra", "", false),
          ],
          false),
      Question(
          14,
          "14. ¿Con quién consume su almuerzo?",
          [
            Option(1, "Con mi familia", "", false),
            Option(2, "Con mis amigos", "", false),
            Option(3, "Con mis compañeros de estudio.", "", false),
            Option(4, "Con mis compañeros de trabajo", "", false),
            Option(5, "Solo", "", false),
          ],
          false),
      Question(
          15,
          "15. ¿Cuántas veces a la semana suele cenar?",
          [
            Option(1, "Nunca", "", false),
            Option(2, "1‐2 Veces a la semana", "", false),
            Option(3, "3‐4 Veces a la semana", "", false),
            Option(4, "5‐6 veces a la semana ", "", false),
            Option(5, "Diario", "", false),
          ],
          false),
      Question(
          16,
          "16. ¿Dónde consume su cena?",
          [
            Option(1, "En casa", "", false),
            Option(2, "En el comedor universitario", "", false),
            Option(3, "En un restaurante", "", false),
            Option(4, "En un restaurante", "", false),
            Option(5, "En los Puestos de ambulantes", "", false),
          ],
          false),
      Question(
          17,
          "17. ¿Qué suele consumir mayormente en su cena?",
          [
            Option(1, "Comida Criolla ", "", false),
            Option(2, "Comida Vegetariana ", "", false),
            Option(3, "Comida Light", "", false),
            Option(4, "Pollo a la brasa y / o Pizzas", "", false),
            Option(5, "Comida Chatarra", "", false),
          ],
          false),
      Question(
          18,
          "18. ¿Con quién consume su cena?",
          [
            Option(1, "Con mi familia", "", false),
            Option(2, "Con mis amigos", "", false),
            Option(3, "Con mis compañeros de estudio.", "", false),
            Option(4, "Con mis compañeros de trabajo", "", false),
            Option(5, "Solo", "", false),
          ],
          false),
      Question(
          19,
          "19. ¿Qué tipo de preparación (en el desayuno, almuerzo o cena) suele consumir con mayor frecuencia durante la semana?",
          [
            Option(1, "Guisado", "", false),
            Option(2, "Sancochado", "", false),
            Option(3, "Frituras ", "", false),
            Option(4, "Al Horno", "", false),
            Option(5, "A la Plancha", "", false),
          ],
          false),
      Question(
          20,
          "20. ¿Cuántas veces suele consumir huevo?",
          [
            Option(1, "Nunca", "", false),
            Option(2, "1‐2 veces al mes", "", false),
            Option(3, "1‐2 veces a la semana", "", false),
            Option(4, "Interdiario ", "", false),
            Option(5, "Diario", "", false),
          ],
          false),
      Question(
          21,
          "21.	¿Cuántas veces suele consumir ensaladas de verduras? ",
          [
            Option(1, "Nunca", "", false),
            Option(2, "1‐2 veces al mes", "", false),
            Option(3, "1‐2 veces a la semana", "", false),
            Option(4, "Interdiario ", "", false),
            Option(5, "Diario", "", false),
          ],
          false),
      Question(
          22,
          "22.	¿Suele agregar sal a las comidas preparadas? ",
          [
            Option(1, "Nunca", "", false),
            Option(2, "Simpre", "", false),
            Option(3, "A veces", "", false),
          ],
          false),
      Question(
          23,
          "23.	¿Suele agregar aceite a las comidas preparadas? ",
          [
            Option(1, "Ninguna ", "", false),
            Option(2, "1 cucharadita", "", false),
            Option(3, "2 cucharaditas ", "", false),
            Option(4, "3 cucharaditas", "", false),
            Option(5, "Más de 3 cucharaditas", "", false),
          ],
          false),
      Question(
          24,
          "24.	¿Con qué frecuencia consumes alguna bebida alcohólica? ",
          [
            Option(1, "Una o dos veces por semana.", "", false),
            Option(2, "Una o dos veces por mes", "", false),
            Option(3, "Una o dos veces al año", "", false),
            Option(4, "Nunca", "", false),
          ],
          false),
      Question(
          25,
          "25.	Cuando consumes alcohol en un día, ¿hasta cuántas bebidas sueles consumir? ",
          [
            Option(1, "Menos de una botella", "", false),
            Option(2, "De una a dos botellas", "", false),
            Option(3, "De tres a cuatro botellas", "", false),
            Option(4, "De cinco a sei botellass", "", false),
            Option(5, "De siete a nueve botellas", "", false),
            Option(6, "De diez o más botellas", "", false),
          ],
          false),
      Question(
          26,
          "26.	¿Consumes algún suplemento nutricional de proteínas, vitaminas o minerales? ",
          [
            Option(1, "Si consumo", "", false),
            Option(2, "No consumo", "", false),
            Option(3, "Consumo a veces", "", false),
          ],
          false),
    ];
  }
}
