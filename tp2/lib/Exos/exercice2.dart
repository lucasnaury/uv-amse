import 'package:flutter/material.dart';

class Exercice1 extends StatefulWidget {
  const Exercice1({super.key});

  @override
  State<Exercice1> createState() => _Exercice1State();
}

class _Exercice1State extends State<Exercice1> {
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: Column(
        children: [
          Image.asset('assets/imgs/taquin.jpg'),
          Slider(
            value: _currentSliderValue,
            max: 100,
            divisions: 5,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
