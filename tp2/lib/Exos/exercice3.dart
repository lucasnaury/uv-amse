import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tp2/Exos/exercice1.dart';
import 'package:tp2/Exos/exercice2.dart';

/// Flutter code sample for [ListTile].

class Exercice3 extends StatelessWidget {
  const Exercice3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Liste des exercices'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 1'),
              subtitle: const Text("Affichage d'une image"),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex1'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 2'),
              subtitle: const Text("Rotation, échelle, animation d'une image"),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex2'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 4'),
              subtitle: const Text("Rogner une image"),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex4'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 5'),
              subtitle: const Text("Découper une image en grille de tuiles"),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex5'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 6a'),
              subtitle: const Text("Déplacer des tuiles"),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex6a'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: const Text('Exercice 6b'),
              subtitle:
                  const Text("Déplacer des tuiles dans une grille complète"),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/ex6b'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/imgs/taquin-icon.jpg"),
              title: const Text('Taquin'),
              subtitle: const Text("Jeu du taquin, exercice final"),
              trailing: const Icon(Icons.play_arrow),
              onTap: () => GoRouter.of(context).push('/taquin'),
            ),
          ),
        ],
      ),
    );
  }
}
