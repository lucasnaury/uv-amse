import 'package:flutter/material.dart';

class Exercice5 extends StatefulWidget {
  const Exercice5({super.key});

  @override
  State<Exercice5> createState() => _Exercice5State();
}

class Tile {
  String imageURL;
  Alignment alignment;
  int gridSize;

  Tile(
      {required this.imageURL,
      required this.gridSize,
      required this.alignment});

  //Create a cropped image tile
  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: alignment,
            widthFactor: 1.0 / gridSize,
            heightFactor: 1.0 / gridSize,
            child: Image.asset(imageURL),
          ),
        ),
      ),
    );
  }
}

class _Exercice5State extends State<Exercice5> {
  int gridSize = 4;

  List<Widget> tileWidgets = [];

  @override
  void initState() {
    super.initState();

    updateTiles();
  }

  void updateTiles() {
    tileWidgets = [];

    var offsetStep = 2 / (gridSize - 1);

    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        tileWidgets.add(
          createTileWidgetFrom(
            Tile(
              alignment: Alignment(-1 + offsetStep * j, -1 + offsetStep * i),
              gridSize: gridSize,
              imageURL: "assets/imgs/taquin.jpg",
            ),
          ),
        );
      }
    }
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercice 5')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              alignment: Alignment.topCenter,
              width: 350,
              child: Column(
                children: [
                  //Create a grid of the slider size
                  GridView.count(
                      primary: false,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      shrinkWrap: true,
                      crossAxisCount: gridSize,
                      children: tileWidgets),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text("Size : "),
                      Expanded(
                        child: Slider(
                          value: gridSize.toDouble(),
                          min: 2,
                          max: 6,
                          divisions: 4,
                          label: gridSize.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              gridSize = value.round();
                              updateTiles();
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
        ),
      ),
    );
  }
}
