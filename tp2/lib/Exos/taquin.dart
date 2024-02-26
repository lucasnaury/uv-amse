import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async'; // Importer le package 'dart:async' pour utiliser le chronomètre

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

// ==============
// Models
// ==============

math.Random random = math.Random();

class Tile {
  Image image;
  Alignment alignment;
  int gridSize;
  bool empty;
  List<int> originalPos;

  Tile(
      {required this.image,
      required this.gridSize,
      required this.alignment,
      required this.originalPos,
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
            child: image,
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
  int nbMelange = 4 * 4;
  late int emptyTileIndex;
  int previousEmptyTileIndex = -1;

  bool playing = false;
  int nbCoups = 0;

  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTime = "0:00";

  late ImagePicker imagePicker;
  static String defaultImageUrl = "assets/imgs/taquin.jpg";
  Image image = Image.asset(defaultImageUrl);

  void swapTiles(int src, {bool userAction = true}) {
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
        if (userAction) {
          previousEmptyTileIndex = emptyTileIndex;
        }
        emptyTileIndex = src;

        //Update count
        if (userAction) {
          nbCoups++;
        }

        // Check for victory
        if (userAction && checkVictory()) {
          //Only check for victory if the user is playing
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

          //Pause timer
          _stopwatch.stop();
          _timer.cancel();
        }
      });
    }
  }

  void undoAction() {
    //Make sure we can undo
    if (previousEmptyTileIndex == -1) {
      return;
    }

    //Undo action
    swapTiles(previousEmptyTileIndex, userAction: false);
    nbCoups--;

    //Reset history
    previousEmptyTileIndex = -1;
  }

  bool checkVictory() {
    for (int i = 0; i < tiles.length; i++) {
      int iLine = i ~/ gridSize;
      int iCol = i % gridSize;

      if (tiles[i].originalPos[0] != iLine || tiles[i].originalPos[1] != iCol) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    imagePicker = ImagePicker();

    updateTiles();
    initTimer();
  }

  void initTimer() {
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_stopwatch.isRunning) {
        setState(() {
          _elapsedTime = formatTime(_stopwatch.elapsed);
        });
      }
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();

    _timer.cancel();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = duration.inMinutes.toString();
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
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
            image: image,
            originalPos: [i, j],
          ),
        );
      }
    }
  }

  void selectImage(ImageSource source) async {
    XFile? pickedImage = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedImage != null) {
      setState(() {
        image = Image.file(File(pickedImage.path));

        updateTiles();
      });
    }
  }

  void newGame() {
    //Decide empty square
    emptyTileIndex = random.nextInt(gridSize * gridSize);

    tiles[emptyTileIndex].empty = true;

    //Swap random tiles
    do {
      for (int i = 0; i < nbMelange; i++) {
        //Get all adjacent tiles
        var listAdjacent = [];
        for (int tile = 0; tile < gridSize * gridSize; tile++) {
          if (isAdjacent(tile)) {
            listAdjacent.add(tile);
          }
        }
        //Swap empty tile with any adjacent tile
        swapTiles(listAdjacent[random.nextInt(listAdjacent.length)],
            userAction: false);
      }
    } while (checkVictory()); //Swap tiles until the map is not already finished
  }

  void restart() {
    //Reset timer
    _stopwatch.reset();
    _timer.cancel();
    _elapsedTime = '0:00';
    initTimer();

    setState(() {
      //Reset variables
      playing = false;
      nbCoups = 0;

      //Recreate base grid
      updateTiles();
    });
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
        title: const Text('Taquin'),
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
                                //Update params
                                gridSize = value.round();
                                if (nbMelange < gridSize * gridSize) {
                                  nbMelange = gridSize * gridSize;
                                } else if (nbMelange >
                                    gridSize * gridSize * 2) {
                                  nbMelange = gridSize * gridSize * 2;
                                }

                                //Regenerate grid
                                updateTiles();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !playing,
                    child: Row(
                      children: [
                        const Text("Difficulty : "),
                        Expanded(
                          child: Slider(
                            value: nbMelange.toDouble(),
                            min: (gridSize * gridSize).toDouble(),
                            max: (gridSize * gridSize * 2).toDouble(),
                            divisions: (gridSize * gridSize),
                            label: nbMelange.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                nbMelange = value.round();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: playing,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        nbCoups.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: playing,
                    child: Text(
                      'Temps écoulé: $_elapsedTime',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image gallery button
          Visibility(
            visible: !playing,
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () {
                  selectImage(ImageSource.gallery);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                  iconColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ),
          //Undo button
          Visibility(
            visible: playing,
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.undo),
                onPressed: previousEmptyTileIndex == -1 ? null : undoAction,
                style: ButtonStyle(
                  backgroundColor: previousEmptyTileIndex == -1
                      ? MaterialStateProperty.all<Color>(Colors.grey)
                      : MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                  iconColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ),
          //Main btn (play or restart)
          Container(
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
                    _stopwatch.reset();
                    _stopwatch.start();
                  } else {
                    restart();
                    _stopwatch.stop();
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary),
                iconColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
          //Photo app button
          Visibility(
            visible: !playing,
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.photo_camera),
                onPressed: () {
                  selectImage(ImageSource.camera);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                  iconColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
