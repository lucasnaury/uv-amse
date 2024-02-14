import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.asset(imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile =
    Tile(imageURL: 'assets/imgs/taquin.jpg', alignment: const Alignment(0, 1));

class Exercice4 extends StatefulWidget {
  @override
  State<Exercice4> createState() => _DisplayTileWidgetState();
}

class _DisplayTileWidgetState extends State<Exercice4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display a Tile as a Cropped Image'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: createTileWidgetFrom(tile))),
        Container(
            height: 200,
            child: Image.asset('assets/imgs/taquin.jpg', fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
