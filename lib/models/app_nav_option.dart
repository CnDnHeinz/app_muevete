import 'package:flutter/material.dart';

class AppNavOption {
  IconData icono;
  String label;
  bool activo;
  AppNavOption(this.icono, this.label, this.activo);
}

List<AppNavOption> navigatorItems = [
  AppNavOption(Icons.home, "", false),
  AppNavOption(Icons.bar_chart_outlined, "", false),
  AppNavOption(Icons.directions_run_rounded, "", true),
  AppNavOption(Icons.dining, "", false),
  AppNavOption(Icons.logout, "", false),
];
