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
    return Scaffold(
      appBar: AppBar(title: const Text('Liste Exercice')),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 1'),
              subtitle: const Text('Here is a second line'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex1'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 2'),
              subtitle: const Text(
                  'A sufficiently long subtitle warrants three lines.'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex2'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 4'),
              subtitle: const Text(
                  'A sufficiently long subtitle warrants three lines.'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex4'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 5'),
              subtitle: const Text(
                  'A sufficiently long subtitle warrants three lines.'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex5'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 5'),
              subtitle: const Text(
                  'A sufficiently long subtitle warrants three lines.'),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex6'),
            ),
          ),
        ],
      ),
    );
  }
}
