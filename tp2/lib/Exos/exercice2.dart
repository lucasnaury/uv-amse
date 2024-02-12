import 'package:flutter/material.dart';

class Exercice2 extends StatefulWidget {
  const Exercice2({super.key});

  @override
  State<Exercice2> createState() => _Exercice2State();
}

class _Exercice2State extends State<Exercice2> {
  double rotateXVal = 20;
  double rotateZVal = 20;
  double scale = 20;
  bool mirror = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Slider')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/imgs/taquin.jpg'),
              Row(
                children: [
                  const Text("RotateX :"),
                  Slider(
                    value: rotateXVal,
                    max: 100,
                    label: rotateXVal.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        rotateXVal = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("RotateZ :"),
                  Slider(
                    value: rotateZVal,
                    max: 100,
                    label: rotateZVal.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        rotateZVal = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Mirror :"),
                  Checkbox(
                    value: mirror,
                    onChanged: (bool? state) => setState(() {
                      mirror = state!;
                    }),
                  )
                ],
              ),
              Row(
                children: [
                  const Text("Scale :"),
                  Slider(
                    value: scale,
                    max: 100,
                    label: scale.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        scale = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
