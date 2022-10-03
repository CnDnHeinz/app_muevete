import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:app_muevete/components/app_acordion.dart';
import 'package:app_muevete/components/app_button.dart';
import 'package:app_muevete/models/eat.dart';
import 'package:app_muevete/models/meal.dart';
import 'package:app_muevete/services/meals_service.dart';
import 'package:app_muevete/services/stadistics_service.dart';
import 'package:app_muevete/utils/app_colors.dart';
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
  final _serviceStats = new StadisticsService();

  final _today = DateTime.now();

  Widget _header() {
    final builder = FutureBuilder<dynamic>(
      future: _serviceStats.loasStats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return Text(
            snapshot.data["habito"]["descripcion"],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          );
        }
        return Container();
      },
    );

    return Column(
      children: [
        Center(
          child: builder,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Fecha : ${_today.day.toString()}/${_today.month.toString()}/${_today.year.toString()}",
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Los datos de guardan automaticamente al seleccionar.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[700]!,
          ),
        ),
      ],
    );
  }

  Widget _getBody(List<Meal> data) {
    return Accordion(
      maxOpenSections: 3,
      disableScrolling: true,
      headerBackgroundColorOpened: AppColors.primary,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: data
          .map<AccordionSection>(
            (e) => AccordionSection(
              isOpen: false,
              leftIcon: Image(
                height: 30.0,
                image:
                    AssetImage("assets/img/comida" + e.id.toString() + ".png"),
              ),
              header: Text(e.descripcion, style: _headerStyle),
              content: Column(children: _options(e.platos)),
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
                  /* setState(() {
                    _service.storeEats(e);
                  }); */
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
          title: const Text("Habitos nutricionales"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: <Color>[Colors.orange[200]!, Colors.green[800]!]),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                _header(),
                builder,
                /* AppButton(
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
                ) */
              ],
            ),
          ),
        ));
  }
}
