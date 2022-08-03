import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CronometroComponent extends StatefulWidget {
  final int? duracion;
  const CronometroComponent({Key? key, this.duracion}) : super(key: key);

  @override
  State<CronometroComponent> createState() => _CronometroComponentState();
}

class _CronometroComponentState extends State<CronometroComponent> {
  int milisec = 0;
  Timer? timer;

  bool finished = false;

  iniciarTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {
        milisec += 100;
      });

      if (new Duration(milliseconds: milisec).inMinutes == widget.duracion) {
        t.cancel();
        finished = true;
      }
    });
  }

  String formatTime() {
    Duration duration = Duration(milliseconds: milisec);
    String hours = paddingLeft(duration.inHours);
    String minutes = paddingLeft(duration.inMinutes % 60);
    String seconds = paddingLeft(duration.inSeconds % 60);
    int milliseconds = duration.inMilliseconds % 1000;
    return '$hours:$minutes:$seconds:$milliseconds';
  }

  String paddingLeft(int value) {
    return value < 10 ? '0$value' : '$value';
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
          SizedBox(
            height: 20,
          ),
          Text(formatTime(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey[800],
              )),
          RaisedButton(
            child: Text('Iniciar ejercicio'),
            onPressed: () {
              iniciarTimer();
            },
          ),
        ],
      ),
    );
  }
}
