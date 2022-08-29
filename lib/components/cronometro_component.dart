import 'dart:async';

import 'package:app_muevete/models/exercise.dart';
import 'package:app_muevete/services/exersice_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CronometroComponent extends StatefulWidget {
  final int? duracion;
  final Exercise? ejercicio;
  const CronometroComponent({Key? key, this.duracion, this.ejercicio})
      : super(key: key);

  @override
  State<CronometroComponent> createState() => _CronometroComponentState();
}

class _CronometroComponentState extends State<CronometroComponent> {
  int milisec = 0;
  Timer? timer;

  bool finished = false;
  bool is_active = false;

  final _service = new ExersiceService();

  iniciarTimer() {
    if (!is_active) {
      timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
        setState(() {
          milisec += 100;
        });

        if (new Duration(milliseconds: milisec).inMinutes == widget.duracion) {
          t.cancel();
          finished = true;

          submitData(true, formatTime());
        }
      });

      setState(() {
        is_active = !is_active;
      });
    } else {
      timer?.cancel();
      setState(() {
        is_active = !is_active;
      });
    }
  }

  detenerTimer() {
    timer?.cancel();
    submitData(false, formatTime());
    setState(() {
      milisec = 0;
      is_active = !is_active;
    });
  }

  String formatTime() {
    Duration duration = Duration(milliseconds: milisec);
    String hours = paddingLeft(duration.inHours);
    String minutes = paddingLeft(duration.inMinutes % 60);
    String seconds = paddingLeft(duration.inSeconds % 60);
    //int milliseconds = duration.inMilliseconds % 1000;
    return '$hours:$minutes:$seconds';
  }

  String paddingLeft(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  submitData(bool completed, String duracion) {
    if (widget.ejercicio != null) {
      _service.storeExercises({
        'id': widget.ejercicio!.id,
        'descripcion': widget.ejercicio!.description,
        'duracion': duracion,
        'completed': completed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          finished
              ? Container(
                  height: 50,
                  child: Image(
                    image: AssetImage('assets/img/check.png'),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          const SizedBox(
            height: 20,
          ),
          Text(formatTime(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[800],
              )),
          const SizedBox(
            height: 20,
          ),
          !finished
              ? Row(
                  mainAxisAlignment: !is_active
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      child: Text(!is_active ? 'Iniciar ejercicio' : 'Pausar'),
                      onPressed: () {
                        iniciarTimer();
                      },
                    ),
                    is_active
                        ? RaisedButton(
                            child: const Text('Detener rutina'),
                            onPressed: () {
                              detenerTimer();
                            },
                          )
                        : Container()
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
