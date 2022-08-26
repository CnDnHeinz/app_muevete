import 'package:app_muevete/models/app_nav_option.dart';
import 'package:app_muevete/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppNavBar extends StatefulWidget {
  final List<AppNavOption> items;

  const AppNavBar({Key? key, required this.items}) : super(key: key);

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> opciones = [];

    for (var i = 0; i < widget.items.length; i++) {
      opciones.add(
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(widget.items[i].icono,
                color:
                    widget.items[i].activo ? AppColors.primary : Colors.grey),
          ),
        ),
      );
    }

    return BottomAppBar(
      elevation: 10.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: opciones,
      ),
    );
  }
}
