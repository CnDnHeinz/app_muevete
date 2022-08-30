import 'package:app_muevete/models/exercise.dart';
import 'package:app_muevete/pages/stadistics/ejercicio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EjercicioComponente extends StatefulWidget {
  final Exercise? exercise;
  const EjercicioComponente({Key? key, this.exercise}) : super(key: key);

  @override
  State<EjercicioComponente> createState() => _EjercicioComponenteState();
}

class _EjercicioComponenteState extends State<EjercicioComponente> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _active = !_active;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Ejercicio(ejercicio: widget.exercise)));
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 120.0,
          child: Stack(fit: StackFit.expand, children: [
            Image(
              image: AssetImage(
                  'assets/img/' + (widget.exercise?.image ?? 'logo-app')),
              width: 100.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            Container(
              /* color: Colors.black.withOpacity(_active ? 0.0 : 0.5), */
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[800]!.withOpacity(_active ? 0.0 : 0.5), 
                    Colors.green[800]!.withOpacity(_active ? 0.0 : 0.5),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                
              ),
              child: Center(
                child: Text(
                  widget.exercise?.name ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white.withOpacity(_active ? 00 : 1.0)),
                ),
              ),
            )
          ]),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
