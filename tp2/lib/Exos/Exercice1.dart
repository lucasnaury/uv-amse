import 'package:flutter/material.dart';

class Exercice1 extends StatelessWidget {
  const Exercice1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image')),
      body: SafeArea(
        child: Center(child: Image.asset('assets/imgs/taquin.jpg')),
      ),
    );
  }
}
