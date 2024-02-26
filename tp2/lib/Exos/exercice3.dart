import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          ExerciceItem(
            icon: Icons.looks_one,
            title: "Exercice 1",
            desc: "Affichage d'une image",
            route: '/ex1',
          ),
          ExerciceItem(
            icon: Icons.looks_two,
            title: "Exercice 2",
            desc: "Rotation, échelle, animation d'une image",
            route: '/ex2',
          ),
          ExerciceItem(
            icon: Icons.looks_4,
            title: "Exercice 4",
            desc: "Rogner une image",
            route: '/ex4',
          ),
          ExerciceItem(
            icon: Icons.looks_5,
            title: "Exercice 5",
            desc: "Découper une image en grille de tuiles",
            route: '/ex5',
          ),
          ExerciceItem(
            icon: Icons.looks_6,
            title: "Exercice 6a",
            desc: "Déplacer des tuiles",
            route: '/ex6a',
          ),
          ExerciceItem(
            icon: Icons.looks_6,
            title: "Exercice 6b",
            desc: "Déplacer des tuiles dans une grille complète",
            route: '/ex6b',
          ),
          ExerciceItem(
            leading: Image.asset("assets/imgs/taquin-icon.jpg", width: 40),
            title: "Taquin",
            desc: "Jeu du taquin, exercice final",
            route: '/taquin',
          ),
        ],
      ),
    );
  }
}

class ExerciceItem extends StatelessWidget {
  final IconData? icon;
  final Widget? leading;
  final String title;
  final String desc;
  final String route;

  ExerciceItem({
    super.key,
    required this.title,
    required this.desc,
    required this.route,
    this.icon,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icon != null ? Icon(icon, size: 40) : leading,
        title: Text(title),
        subtitle: Text(desc),
        trailing: const Icon(Icons.play_arrow),
        onTap: () => GoRouter.of(context).push(route),
      ),
    );
  }
}
