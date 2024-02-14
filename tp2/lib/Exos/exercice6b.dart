import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = math.Random();

class Tile {
  late Color color;

  Tile(this.color);
  Tile.randomColor() {
    color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget(this.tile, {super.key});

  @override
  Widget build(BuildContext context) {
    return coloredBox();
  }

  Widget coloredBox() {
    return Container(
      color: tile.color,
      child: const Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}

class Exercice6b extends StatefulWidget {
  const Exercice6b({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<Exercice6b> {
  int gridSize = 4;
  int emptyTileIndex = 6;

  void swapTiles(int src) {
    bool sameLine = src ~/ gridSize == emptyTileIndex ~/ gridSize;
    bool sameColumn = src % gridSize == emptyTileIndex % gridSize;

    bool leftOrRight =
        sameLine && (src == emptyTileIndex - 1 || src == emptyTileIndex + 1);
    bool aboveOrBelow = sameColumn &&
        (src == emptyTileIndex - gridSize || src == emptyTileIndex + gridSize);

    //Check if valid tile to swap (above, below, left or right)
    if (aboveOrBelow || leftOrRight) {
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

  Widget createTileWidgetFrom(TileWidget tile, int index) {
    return InkWell(
      child: tile,
      onTap: () {
        //Try to swap tiles on tap
        swapTiles(index);
      },
    );
  }

  List<TileWidget> tiles = [];
  @override
  void initState() {
    super.initState();

    tiles = List<TileWidget>.generate(16, (index) {
      if (index == 6) {
        return TileWidget(Tile(Colors.white));
      }

      return TileWidget(Tile.randomColor());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moving Tiles'),
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
