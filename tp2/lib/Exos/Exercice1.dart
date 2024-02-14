import 'package:flutter/material.dart';

class Exercice1 extends StatelessWidget {
  const Exercice1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Exercice 1'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(child: Image.asset('assets/imgs/taquin.jpg')),
      ),
    );
  }
}
