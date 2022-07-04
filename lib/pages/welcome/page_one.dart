import 'package:app_muevete/models/option.dart';
import 'package:app_muevete/models/question.dart';
import 'package:app_muevete/utils/tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PageOne extends StatefulWidget {
  final Question? question;
  final int? questionsLength;

  const PageOne({Key? key, this.question, this.questionsLength}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<Widget> _options(List<Option> options) {
    return options
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child:
              GestureDetector(
                onTap: () {
                  setState(() {
                      if(widget.question?.multiple == true) {
                        e.selected = !e.selected;
                      } else {
                        widget.question?.options?.forEach((element) {
                          element.selected = false;
                        });
                        e.selected = true;
                      }
                    }
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  child:Row(
                    children: [
                      widget.question?.multiple == true ? Checkbox(
                        value: e.selected,
                        onChanged: (value) {},
                      ) : Container(),
                      Flexible(
                        child: Text(
                          e.label,
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
                        offset: Offset(0, 5,),  

                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  Widget _progreso() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          width: 100.0,
          child: LinearProgressIndicator(
            backgroundColor: Colors.green[200],
            value: _calcularProgreso(),
            valueColor: AlwaysStoppedAnimation(Tema().getColorPrimary()),
          ),
        ),
      ),
    );
  }

  double _calcularProgreso() {
    return (widget.question!.id / widget.questionsLength!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _progreso(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      widget.question?.question ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),                  

                  Container(
                    height: 440,
                    child: ListView(
                      children: _options(widget.question?.options ?? []),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //color: Colores().getColorPrimary(),
      ),
    );
  }
}
