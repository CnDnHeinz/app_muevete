import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:app_muevete/components/app_acordion.dart';
import 'package:app_muevete/components/app_button.dart';
import 'package:app_muevete/models/eat.dart';
import 'package:app_muevete/models/meal.dart';
import 'package:app_muevete/services/meals_service.dart';
import 'package:app_muevete/utils/tema.dart';
import 'package:flutter/material.dart';

class Nutricion extends StatefulWidget {
  const Nutricion({Key? key}) : super(key: key);

  @override
  State<Nutricion> createState() => _NutricionState();
}

class _NutricionState extends State<Nutricion> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  List<Meal> _comidas = [];

  final _service = new MealService();

  Widget _header() {
    return Column(
      children: [
        Center(
          child: Text(
            "Hábitos alimentarios poco saludables / Moderadamente activo",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _getBody(List<Meal> data) {
    return Accordion(
      maxOpenSections: 3,
      disableScrolling: true,
      headerBackgroundColorOpened: Colors.black54,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: data
          .map<AccordionSection>(
            (e) => AccordionSection(
              isOpen: true,
              leftIcon: const Icon(Icons.dining_sharp, color: Colors.white),
              header: Text(e.descripcion, style: _headerStyle),
              content: Container(child: Column(children: _options(e.platos))),
            ),
          )
          .toList(),
    );

    /* return Column(
        children: data
            .map<AppAcordion>(
              (e) => AppAcordion(
                title: e.descripcion,
                content: Container(
                  child: Column(
                    children: _options(e.platos),
                  ),
                ),
              ),
            )
            .toList()); */
  }

  List<Widget> _options(List<Eat> options) {
    return options
        .map((e) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _service.storeEats(e);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: e.selected,
                        onChanged: (value) {
                          setState(() {
                            _service.storeEats(e);
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          e.descripcion,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: e.selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: e.selected ? Colors.white : Colors.grey[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: e.selected ? Tema().getColorPrimary() : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: Offset(
                          0,
                          5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final builder = FutureBuilder<dynamic>(
      future: _service.getMeals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return _getBody(snapshot.data);
        }
        return Center(child: Text('Servidor no está disponible'));
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Nutrición"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                _header(),
                builder,
                AppButton(
                  label: "Guardar",
                  fontWeight: FontWeight.w600,
                  padding: EdgeInsets.symmetric(vertical: 25),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Error interno'),
                      content: const Text('El servidor remoto no responde'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('Aceptar'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
