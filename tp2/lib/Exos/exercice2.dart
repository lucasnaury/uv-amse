import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Exercice2 extends StatefulWidget {
  const Exercice2({super.key});

  @override
  State<Exercice2> createState() => _Exercice2State();
}

class _Exercice2State extends State<Exercice2> {
  double rotateXVal = 0;
  double rotateZVal = 0;
  double scale = 1;
  bool mirror = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation
    const d = Duration(milliseconds: 50);
    Timer.periodic(d, animate);
  }

  bool animating = false;
  void animate(Timer t) {
    if (!animating) {
      return;
    }

    print("TIMER");
    double newRotateXVal = rotateXVal + 3.14 / 60;
    double newRotateZVal = rotateZVal + 3.14 / 60;
    double newScale = scale + 0.01;

    setState(() {
      rotateXVal = newRotateXVal > 6.28 ? newRotateXVal - 6.28 : newRotateXVal;
      rotateZVal = newRotateZVal > 6.28 ? newRotateZVal - 6.28 : newRotateZVal;
      scale = newScale > 2 ? newScale - (2 - 0.1) : newScale;
    });

    // t.cancel(); // stops the timer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Exercice 2')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Transform(
                        origin: const Offset(150, 150),
                        transform: Matrix4.identity()
                          ..rotateX(rotateXVal)
                          ..rotateZ(rotateZVal)
                          ..scale(mirror ? -scale : scale, scale),
                        child: Image.asset('assets/imgs/taquin.jpg')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("RotateX :"),
                      Slider(
                        value: rotateXVal,
                        min: 0,
                        max: 6.28,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("RotateZ :"),
                      Slider(
                        value: rotateZVal,
                        min: 0,
                        max: 6.28,
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Scale :"),
                      Slider(
                        value: scale,
                        min: 0.1,
                        max: 2,
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
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(animating ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            setState(() {
              animating = !animating;
            });
          },
          // style: ,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary),
            iconColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
