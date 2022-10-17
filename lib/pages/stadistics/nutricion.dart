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

  final _service = new MealService();
  final _serviceStats = new StadisticsService();
  List<Meal> _comidas = [];
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fecha : ${_today.day.toString()}/${_today.month.toString()}/${_today.year.toString()}",
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              color: AppColors.primary,
              textColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              onPressed: () async {
                try {
                  var resp = await _service.storeEats(_comidas);
                  if (resp['cod_respuesta'] == '1001') {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        title: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(color: Colors.green[800]!),
                          child: const Text('¡Exito!'),
                        ),
                        content: const Text(
                          'Su selección ha sido registrada correctamente',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('Aceptar'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        title: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(color: Colors.green[800]!),
                          child: const Text('¡Error!'),
                        ),
                        content: const Text(
                          'Ha ocurrido un error inesperado al intenter guardar su selección, por favor intentelo más tarde',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('Aceptar'),
                          ),
                        ],
                      ),
                    );
                  }
                } catch (e) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      title: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(color: Colors.red[800]!),
                        child: const Text('¡Error!'),
                      ),
                      content: const Text(
                        'Ha ocurrido un error inesperado al intenter guardar su selección, por favor intentelo más tarde',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text(
                            'Aceptar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                //print(resp);

                /* ; */
              },
              child: const Text('Guardar'),
            )
          ],
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
              isOpen: e.isOpen!,
              leftIcon: Image(
                height: 30.0,
                image:
                    AssetImage("assets/img/comida" + e.id.toString() + ".png"),
              ),
              header: Text(e.descripcion, style: _headerStyle),
              content: Column(children: _options(e.platos)),
              onOpenSection: () {
                setState(() {
                  e.isOpen = true;
                });
              },
              onCloseSection: () {
                setState(() {
                  e.isOpen = false;
                });
              },
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
                    e.selected = !e.selected;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: e.selected ? Tema().getColorPrimary() : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: e.selected,
                        onChanged: (value) {
                          //e.selected = !e.selected;
                          setState(() {
                            e.selected = !e.selected;
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
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final builder = _comidas.length == 0
        ? FutureBuilder<dynamic>(
            future: _service.getMeals(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                _comidas = snapshot.data;
                return _getBody(snapshot.data);
              }
              return Center(child: Text('Servidor no está disponible'));
            },
          )
        : _getBody(_comidas);

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
