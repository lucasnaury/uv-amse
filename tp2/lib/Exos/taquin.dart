import 'package:flutter/material.dart';

class Taquin extends StatelessWidget {
  const Taquin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Taquin'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(child: Image.asset('assets/imgs/taquin.jpg')),
      ),
    );
  }
}
