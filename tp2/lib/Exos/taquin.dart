import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = math.Random();

class Tile {
  String imageURL;
  Alignment alignment;
  int gridSize;
  bool empty;

  Tile(
      {required this.imageURL,
      required this.gridSize,
      required this.alignment,
      this.empty = false});

  //Create a cropped image tile
  Widget croppedImageTile() {
    if (!empty) {
      return FittedBox(
        fit: BoxFit.fill,
        child: ClipRect(
          child: Align(
            alignment: alignment,
            widthFactor: 1.0 / gridSize,
            heightFactor: 1.0 / gridSize,
            child: Image.asset(imageURL),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

// ==============
// Widgets
// ==============

class Taquin extends StatefulWidget {
  const Taquin({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<Taquin> {
  List<Tile> tiles = [];

  int gridSize = 4;
  late int emptyTileIndex;
  late int nbMelange;

  void swapTiles(int src) {
    // bool sameLine = src ~/ gridSize == emptyTileIndex ~/ gridSize;
    // bool sameColumn = src % gridSize == emptyTileIndex % gridSize;

    // bool leftOrRight =
    //     sameLine && (src == emptyTileIndex - 1 || src == emptyTileIndex + 1);
    // bool aboveOrBelow = sameColumn &&
    //     (src == emptyTileIndex - gridSize || src == emptyTileIndex + gridSize);

    //Check if valid tile to swap (above, below, left or right)
    if (isAdjacent(src)) {
      setState(() {
        //Swap tiles in list
        var temp = tiles[src];
        tiles[src] = tiles[emptyTileIndex];
        tiles[emptyTileIndex] = temp;

        //Update new empty pos
        emptyTileIndex = src;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    updateTiles();
    newGame();
  }

  void updateTiles() {
    tiles = [];

    var offsetStep = 2 / (gridSize - 1);

    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        tiles.add(
          Tile(
            alignment: Alignment(-1 + offsetStep * j, -1 + offsetStep * i),
            gridSize: gridSize,
            imageURL: "assets/imgs/taquin.jpg",
          ),
        );
      }
    }
  }

  void newGame() {
    //Decide empty square
    emptyTileIndex = random.nextInt(gridSize * gridSize);

    tiles[emptyTileIndex].empty = true;

    nbMelange = gridSize * gridSize + random.nextInt(gridSize);

    for (int i = 0; i < nbMelange; i++) {
      var listAdjacent = [];
      for (int tile = 0; tile < 16; tile++) {
        if (isAdjacent(tile)) {
          listAdjacent.add(tile);
        }
      }
      swapTiles(random.nextInt(listAdjacent.length));
    }
    //Swap random tiles
  }

  bool isAdjacent(int src) {
    bool sameLine = src ~/ gridSize == emptyTileIndex ~/ gridSize;
    bool sameColumn = src % gridSize == emptyTileIndex % gridSize;

    bool leftOrRight =
        sameLine && (src == emptyTileIndex - 1 || src == emptyTileIndex + 1);
    bool aboveOrBelow = sameColumn &&
        (src == emptyTileIndex - gridSize || src == emptyTileIndex + gridSize);
    return (aboveOrBelow || leftOrRight);
  }

  Widget createTileWidgetFrom(Tile tile, int index) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        //Try to swap tiles on tap
        swapTiles(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Exercice 6b'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              alignment: Alignment.topCenter,
              width: 350,
              child:
                  //Create a grid for the tiles
                  GridView.count(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      children: tiles.asMap().entries.map((entry) {
                        return createTileWidgetFrom(entry.value, entry.key);
                      }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}
