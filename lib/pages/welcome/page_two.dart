import 'package:app_muevete/utils/tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¿Aqui la segunda pregunta?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[900],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                color: Tema().getColorPrimary(),
                onPressed: () {},
                child: Text(
                  "Si",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                color: Colors.grey,
                onPressed: () {
                },
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        //color: Colores().getColorPrimary(),
      ),
    );
  }
}