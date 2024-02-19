import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

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
  bool playing = false;
  late int nbMelange;

  void swapTiles(int src) {
    if (!playing) {
      const snackBar = SnackBar(
        content: Text('Appuyez sur PLAY pour commencer'),
        duration: Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    //Check if valid tile to swap (above, below, left or right)
    if (isAdjacent(src)) {
      setState(() {
        //Swap tiles in list
        var temp = tiles[src];
        tiles[src] = tiles[emptyTileIndex];
        tiles[emptyTileIndex] = temp;

        //Update new empty pos
        emptyTileIndex = src;

        // Check for victory
        if (checkVictory()) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Victoire !'),
                content: const Text('Félicitations, vous avez gagné !'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      restart();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  bool checkVictory() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].alignment !=
          Alignment(-1 + (2 / (gridSize - 1)) * (i % gridSize),
              -1 + (2 / (gridSize - 1)) * (i ~/ gridSize))) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    updateTiles();
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

    //Swap random tiles
    nbMelange = gridSize * gridSize + random.nextInt(gridSize * gridSize);

    for (int i = 0; i < nbMelange; i++) {
      var listAdjacent = [];
      for (int tile = 0; tile < gridSize * gridSize; tile++) {
        if (isAdjacent(tile)) {
          listAdjacent.add(tile);
        }
      }
      swapTiles(listAdjacent[random.nextInt(listAdjacent.length)]);
    }
  }

  void restart() {
    initState();
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
                  Column(
                children: [
                  GridView.count(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      shrinkWrap: true,
                      crossAxisCount: gridSize,
                      children: tiles.asMap().entries.map((entry) {
                        return createTileWidgetFrom(entry.value, entry.key);
                      }).toList()),
                  Visibility(
                    visible: !playing,
                    child: Row(
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
          icon: Icon(playing ? Icons.replay : Icons.play_arrow),
          onPressed: () {
            setState(() {
              //Toggle play state
              playing = !playing;
              //Do action
              if (playing) {
                newGame();
              } else {
                restart();
              }
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
