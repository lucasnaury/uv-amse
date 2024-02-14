import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp2/Exos/exercice1.dart';
import 'package:tp2/Exos/exercice2.dart';
import 'package:tp2/Exos/exercice3.dart';
import 'package:tp2/Exos/exercice4.dart';
import 'package:tp2/Exos/exercice5.dart';
import 'package:tp2/Exos/exercice6a.dart';
import 'package:tp2/Exos/exercice6b.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TP2',
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        initialLocation: '/',
        routes: [
          // top-level route
          GoRoute(
            path: '/',
            builder: (context, state) => const Exercice3(),
          ),
          GoRoute(
            path: '/ex1',
            builder: (context, state) => const Exercice1(),
          ),
          // Exercice 2
          GoRoute(
            path: '/ex2',
            builder: (context, state) => const Exercice2(),
          ),
          GoRoute(
            path: '/ex4',
            builder: (context, state) => Exercice4(),
          ),
          // Exercice 5
          GoRoute(
            path: '/ex5',
            builder: (context, state) => const Exercice5(),
          ),
          GoRoute(
            path: '/ex6a',
            builder: (context, state) => const Exercice6a(),
          ),
          GoRoute(
            path: '/ex6b',
            builder: (context, state) => const Exercice6b(),
          )
        ],
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
    );
  }
}
