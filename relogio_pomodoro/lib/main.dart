import 'package:flutter/material.dart';
import 'tela_inicial.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Relógio Pomodoro',
      home: TelaInicial(),
    );
  }
}
