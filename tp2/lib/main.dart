import 'package:flutter/material.dart';
import 'package:tp2/Exos/exercice1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TP2',
      home: Exercice1(),
    );
  }
}
