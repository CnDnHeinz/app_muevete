import 'package:app_muevete/models/datos_personales.dart';
import 'package:app_muevete/pages/stadistics.dart';
import 'package:app_muevete/services/datos_personales_Service.dart';
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

  Widget _inputText() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: myController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor: Colors.grey[300],
          filled: true,
          hintText: "DNI o código de estudiante",
          prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
          isDense: true),
    );
  }

  Widget _btnContinuar(String text) {
    return ElevatedButton(
      onPressed: () async {
        if (myController.text.isNotEmpty && _findUser) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Stadistcs()),
          );
        }
      },
      style: TextButton.styleFrom(
          backgroundColor: Colors.green[800],
          padding: const EdgeInsets.all(15),
          minimumSize: const Size(double.infinity, 50),
          shape: StadiumBorder()),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
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
            TextSpan(
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

      return Container(
        child: Table(
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
      );
    } else {
      return Expanded(child: Center(child: CircularProgressIndicator()));
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

  @override
  Widget build(BuildContext context) {
    final builder = FutureBuilder<DatosPersonales>(
        future: dp_service.getDatosPersonales(myController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            this._findUser = false;
            return Text("No se encontró los datos personales del estudiante");
          }
          if (snapshot.hasData) {
            this._findUser = true;
            return _tableData(true, snapshot.data);
          }
          return Text('No está disponible');
        });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Datos personales'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Focus(
                  child: _inputText(),
                  onFocusChange: (hasFocus) {
                    print('2:  $hasFocus');
                    if (!hasFocus) {
                      //print('3: ' + myController.text);
                      setState(() {
                        dp_service.getDatosPersonales(myController.text);
                      });
                    }
                  },
                ),
                Expanded(
                  child: Center(child: builder),
                ),
                _btnContinuar('Continuar'),
              ],
            )),
      ),
    );
  }
}
