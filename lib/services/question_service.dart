import 'package:app_muevete/models/option.dart';
import 'package:app_muevete/models/question.dart';

class QuestionService {
  
  /* Future<List<Question>> getQuestions() async {
    return await _questionRepository.getQuestions();
  } */

  List<Question> getAllQuestions() {
    return [
      Question(1, "1. ¿Usted es beneficiario del comedor universitario en la UNHEVAL?", [
        Option(1, "Si", "yes", false),
        Option(2, "No", "no", false),
      ], false),
      Question(2, "2. ¿Cómo consideras tu estado de salud en este momento?", [
        Option(1, "Muy bien", "verygood", false),
        Option(2, "Bien", "good", false),
        Option(3, "Regular", "normal", false),
        Option(4, "Mal", "bad", false),
      ], false),
      Question(3, "3. ¿Te preocupa tu peso?", [
        Option(1, "Si", "yes", false),
        Option(2, "No", "no", false),
      ], false),
      Question(4, "4. Con qué frecuencia practicas ejercicio físico a la semana?", [
        Option(1, "Nunca", "never", false),
        Option(2, "Una vez", "one time", false),
        Option(3, "2 veces", "two times", false),
        Option(4, "3 veces", "three times", false),
        Option(5, "De 4 a 5 veces", "More than four times", false),
      ], false),
      Question(5, "5. ¿Qué tipo de deporte practicas con mayor frecuencia? Actividad física practicas…", [
        Option(1, "Futbol", "soccer", false),
        Option(2, "Vóley", "volley", false),
        Option(3, "Basquet", "basketball", false),
        Option(4, "Baile o danza", "dance", false),
        Option(5, "Caminatas", "walk", false),
        Option(6, "Ciclismo", "cycling", false),
        Option(7, "Natación", "swimming", false),
        Option(8, "Otro", "other", false),
      ], true),
      Question(6, "6. Tu dificultad para realizar ejercicios físicos es…", [
        Option(1, "Por falta de tiempo.", "", false),
        Option(2, "Por falta de voluntad.", "", false),
        Option(3, "Por motivos económicos.", "", false),
        Option(4, "Porque los horarios de estudio o trabajo no me permiten.", "", false),
        Option(5, "Por problemas de salud.", "", false),
        Option(6, "No tengo ninguna dificultad para hacer ejercicios físicos.", "", false),
      ], true),
      Question(7, "7. ¿Cómo es tu actividad física desde que ingresaste a la universidad?", [
        Option(1, "Dejé de hacer ejercicio físico.", "", false),
        Option(2, "Hago ejercicio físico con menos frecuencia.", "", false),
        Option(3, "Hago los mismos ejercicios físicos de siempre.", "", false),
        Option(4, "Empecé a hacer ejercicio físico.", "", false),
        Option(5, "Hago más ejercicio físico que antes.", "", false),
      ],false),
      Question(8, "7. Durante las últimas semanas, ¿En cuántos días caminó por lo menos 10 minutos seguidos?", [
        Option(1, "Ningún día", "", false),
        Option(2, "Uno a dos días", "", false),
        Option(3, "Tres a cuatro días", "", false),
        Option(4, "Cinco a seis días", "", false),
        Option(5, "Todos los días", "", false),
      ], false),
      Question(9, "8. Habitualmente, ¿cuánto tiempo en total dedica a caminar a diario?", [
        Option(1, "Menos de 30 min.", "", false),
        Option(2, "30 a 60 min.", "", false),
        Option(3, "60 a 90 min.", "", false),
        Option(4, "90 a 120 min.", "", false),
        Option(5, "Más de 120 min.", "", false),
      ], false),
      Question(10, "9. Durante las últimas semanas, ¿cuánto tiempo pasó sentado(a) durante un día hábil?", [
        Option(1, "Menos de 1 hora ", "", false),
        Option(2, "1 a 3 horas", "", false),
        Option(3, "3 a 5 horas", "", false),
        Option(4, "5 a 7 horas", "", false),
        Option(5, "Más de 7 horas", "", false),
      ], false),
      Question(11, "10. ¿Realizas actividades físicas moderadas por lo menos 30 minutos diarios?", [
        Option(1, "Si", "", false),
        Option(2, "No", "", false),
      ], false),
      Question(12, "11. ¿Cuántos días a la semana realiza actividad física moderada por lo menos 30 minutos?", [
        Option(1, "Un día a la semana", "", false),
        Option(2, "De dos a tres días por semana", "", false),
        Option(3, "De cuatro a cinco días por semana", "", false),
        Option(4, "Todos los días de la semana.", "", false),
      ], false),
      Question(13, "12. Habitualmente ¿Cuánto tiempo dedica a realizar esa actividad física moderada?", [
        Option(1, "30 a 60 min.", "", false),
        Option(2, "60 a 90 min.", "", false),
        Option(3, "90 a 120 min.", "", false),
        Option(4, "Más de 120 min.", "", false),
      ], false),
      Question(14, "13. ¿Realizas actividades físicas intensas por lo menos 45 minutos diarios?", [
        Option(1, "Si", "", false),
        Option(2, "No", "", false),
      ], false),  
      Question(15, "15. ¿Cuántos días a la semana realiza actividad física intensa por lo menos 45 minutos?", [
        Option(1, "Un día a la semana", "", false),
        Option(2, "De dos a tres días por semana", "", false),
        Option(3, "De cuatro a cinco días por semana", "", false),
        Option(4, "Todos los días de la semana.", "", false),
      ], false),
      Question(16, "16. Habitualmente ¿Cuánto tiempo dedica a realizar esa actividad física intensa?", [
        Option(1, "45 a 90 min.", "", false),
        Option(2, "90 a 120 min.", "", false),
        Option(3, "Más de 120 min.", "", false),
      ], false),
      Question(17, "18. ¿Disfrutas al realizar actividad física?", [
        Option(1, "Siempre", "", false),
        Option(2, "Casi siempre", "", false),
        Option(3, "Algunas veces", "", false),
        Option(4, "Nunca", "", false),
      ], false),
      Question(18, "19. ¿Qué tipo de ejercicios realizas por semana?", [
        Option(1, "Ejercicios de fuerza (pesas, ejercicios con propio peso)", "", false),
        Option(2, "Ejercicios aeróbicos (caminar, correr, algún deporte)", "", false),
        Option(3, "Combinado", "", false),
      ], false),
      Question(19, "19. ¿Recibes o recibías asesoramiento de parte un entrenador, instructor, docente de Educación Física en tus entrenamientos o rutinas? ", [
        Option(1, "Siempre", "", false),
        Option(2, "Casi siempre.", "", false),
        Option(3, "Algunas veces", "", false),
        Option(4, "Nunca", "", false),
      ], false),
    ];
  }
}