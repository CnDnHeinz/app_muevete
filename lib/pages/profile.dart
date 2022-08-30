import 'package:app_muevete/components/app_button.dart';
import 'package:app_muevete/models/datos_personales.dart';
import 'package:app_muevete/pages/stadistics.dart';
import 'package:app_muevete/services/datos_personales_Service.dart';
import 'package:app_muevete/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final myController = TextEditingController();
  final dp_service = DatosPersonalesService();
  bool _findUser = false;
  DatosPersonales? _datosPersonales;

  Widget _inputText() {
    return TextField(
      keyboardType: TextInputType.number,
      maxLength: 8,
      controller: myController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor: Colors.grey[300],
          filled: true,
          hintText: "Ingrese su DNI",
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                dp_service.getDatosPersonales(myController.text);
              });
            },
            icon: const Icon(Icons.search, color: AppColors.primary),
            color: Colors.red,
          ),
          isDense: true),
    );
  }

  Widget _tableData(state, DatosPersonales? info) {
    if (state) {
      List<Widget> nombre = [];
      nombre.add(Text(
        'Nombre',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
      ));
      nombre.add(Text(
        info?.inf_persona.nombres ?? '',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[800]),
      ));

      List<Widget> apellidos = [];
      apellidos.add(Text(
        'Apellidos',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
      ));
      apellidos.add(RichText(
        text: TextSpan(
          text: info?.inf_persona.paterno ?? '',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey[800]),
          children: [
            const TextSpan(
              text: ' ',
            ),
            TextSpan(
              text: info?.inf_persona.materno ?? '',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[800]),
            ),
          ],
        ),
      ));

      List<Widget> escuela = [];
      escuela.add(Text(
        'Escuela profesional',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
      ));
      if ((info?.inf_alumno ?? []).length > 0) {
        escuela.add(Text(
          info?.inf_alumno[0]?.escuela ?? '',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey[800]),
        ));
      }

      List<Widget> telefono = [];
      telefono.add(Text(
        'Telefono',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
      ));
      telefono.add(Text(
        info?.inf_persona.telefono ?? '',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[800]),
      ));

      List<Widget> sexo = [];
      sexo.add(Text(
        'Sexo',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
      ));
      sexo.add(Text(
        _getSexo(info?.inf_persona.id_sexo ?? ''),
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[800]),
      ));

      return Column(
        children: [
          const Image(
            width: 150.0,
            image: AssetImage("assets/img/logo-app.png"),
          ),
          const SizedBox(height: 30),
          Table(
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(4),
            },
            children: [
              TableRow(
                children: nombre,
              ),
              TableRow(
                children: apellidos,
              ),
              TableRow(
                children: escuela,
              ),
              TableRow(
                children: telefono,
              ),
              TableRow(
                children: sexo,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Image(
            width: 150.0,
            image: (_getSexo(info?.inf_persona.id_sexo ?? '') == "FEMENINO")
                ? const AssetImage("assets/img/avatar/profile_female.png")
                : const AssetImage("assets/img/avatar/profile_male.png"),
          ),
        ],
      );
    } else {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  String _getSexo(String id) {
    if (id == '1') {
      return 'MASCULINO';
    } else if (id == '2') {
      return 'FEMENINO';
    } else {
      return 'NO ESPECIFICADO';
    }
  }

  Widget _defaultScreen() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          "No se encontró los datos personales del estudiante",
          textAlign: TextAlign.center,
        ),
        SizedBox(height:20.0),
        Image(
          height:100.0,
          image: AssetImage("assets/img/logo-app.png"),
        ),
        SizedBox(height: 20.0),
        Image(
          image: AssetImage("assets/img/avatar/avatar_normal.png"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final builder = FutureBuilder<DatosPersonales>(
        future: dp_service.getDatosPersonales(myController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            _findUser = false;
            return _defaultScreen();
          }
          if (snapshot.hasData) {
            _findUser = true;
            _datosPersonales = snapshot.data;
            return _tableData(true, snapshot.data);
          }
          return const Text('No está disponible');
        });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Datos personales'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: <Color>[Colors.orange[200]!, Colors.green[800]!]),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _inputText(),
                Expanded(
                  child: Center(child: builder),
                ),
                AppButton(
                  label: "Continuar",
                  fontWeight: FontWeight.w600,
                  onPressed: () async {
                    if (myController.text.isNotEmpty && _findUser) {
                      dp_service.storeDatosPersonales(_datosPersonales);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Stadistcs()),
                      );
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
