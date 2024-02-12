import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp2/Exos/exercice1.dart';
import 'package:tp2/Exos/exercice2.dart';

/// Flutter code sample for [ListTile].

void main() => runApp(const Exercice3());

class Exercice3 extends StatelessWidget {
  const Exercice3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Exercice3Example(),
    );
  }
}

class Exercice3Example extends StatelessWidget {
  const Exercice3Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste Exercice')),
      body: ListView(
        children: <Widget>[
          const Card(
            child: ListTile(
              title: Text('Liste déroulante des exerices allant de 1 à 7'),
              dense: true,
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 1'),
              subtitle: const Text('Here is a second line'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push(Exercice1),
            ),
          ),
          const Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('Exercice 2'),
              subtitle:
                  Text('A sufficiently long subtitle warrants three lines.'),
              trailing: Icon(Icons.play_arrow),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }
}
