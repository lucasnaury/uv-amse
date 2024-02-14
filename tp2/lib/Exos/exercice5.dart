import 'package:flutter/material.dart';

class Exercice5 extends StatefulWidget {
  const Exercice5({super.key});

  @override
  State<Exercice5> createState() => _Exercice5State();
}

class _Exercice5State extends State<Exercice5> {
  int gridSize = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercice 5')),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GridView.count(
                primary: false,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                shrinkWrap: true,
                crossAxisCount: 3,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                    child: const Center(child: Text("Tile 1")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[200],
                    child: const Center(child: Text("Tile 2")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[300],
                    child: const Center(child: Text("Tile 3")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[400],
                    child: const Center(child: Text("Tile 4")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[500],
                    child: const Center(child: Text("Tile 5")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[600],
                    child: const Center(child: Text("Tile 6")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[700],
                    child: const Center(child: Text("Tile 7")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[800],
                    child: const Center(child: Text("Tile 8")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[900],
                    child: const Center(child: Text("Tile 9")),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Text("Size : "),
                  Expanded(
                    child: Slider(
                      value: gridSize.toDouble(),
                      min: 2,
                      max: 8,
                      divisions: 6,
                      label: gridSize.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          gridSize = value.round();
                        });
                      },
                    ),
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
