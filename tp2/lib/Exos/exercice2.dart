import 'package:flutter/material.dart';

class Exercice2 extends StatefulWidget {
  const Exercice2({super.key});

  @override
  State<Exercice2> createState() => _Exercice2State();
}

class _Exercice2State extends State<Exercice2> {
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Slider')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
        ),
      ),
    );
  }
}
