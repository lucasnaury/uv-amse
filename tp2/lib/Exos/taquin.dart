import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async'; // For the StopWatch
import 'package:confetti/confetti.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tp2/helpers.dart';

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
  bool isAdjacent;

  Tile(
      {required this.image,
      required this.gridSize,
      required this.alignment,
      required this.originalPos,
      this.isAdjacent = false,
      this.empty = false});

  //Create a cropped image tile
  Widget croppedImageTile() {
    if (!empty) {
      return Container(
        foregroundDecoration: isAdjacent
            ? BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
              )
            : null,
        child: FittedBox(
          fit: BoxFit.fill,
          child: ClipRect(
            child: Align(
              alignment: alignment,
              widthFactor: 1.0 / gridSize,
              heightFactor: 1.0 / gridSize,
              child: image,
            ),
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
  // VARIABLES
  // List containing all the tiles
  List<Tile> tiles = [];

  // Grid params
  int gridSize = 4;
  int nbMelange = 4 * 4;
  late int emptyTileIndex;
  List<int> previousEmptyTileIndexes = [];

  // Game state
  bool playing = false;
  int nbCoups = 0;

  // Time params
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTime = "0:00";

  // Image params
  late ImagePicker imagePicker;
  static String localImageUrl = "assets/imgs/taquin.jpg";
  static String networkImageUrl = "https://picsum.photos/1024/1024";
  Image image = Image.asset(localImageUrl);
  bool showBaseImage = false;
  late GridView baseImageGrid;

  //Confetti
  late ConfettiController _confettisController;

  // INHERITED FUNCTIONS
  @override
  void initState() {
    super.initState();

    _confettisController =
        ConfettiController(duration: const Duration(seconds: 10));

    imagePicker = ImagePicker();

    // Init the grid with the default size
    updateTiles();
    initTimer();
  }

  void initTimer() {
    // Create a stopwatch to store the elapsed time
    _stopwatch = Stopwatch();

    // Create a timer to periodically show the elapsed time
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
    // Kill all timer objects
    _stopwatch.stop();
    _timer.cancel();

    super.dispose();
  }

  // FUNCTIONS

  // Start the game (set one empty tile, shuffle the grid and start timer)
  void newGame() {
    //Decide empty square
    emptyTileIndex = random.nextInt(gridSize * gridSize);

    //Set initial empty tile
    tiles[emptyTileIndex].empty = true;

    //Get initial adjacent tiles
    updateAdjacentTiles();

    //Save the previous tile
    int previousTile = -1;

    //Swap random tiles
    do {
      for (int i = 0; i < nbMelange; i++) {
        //Get adjacent tiles that are not the previous one
        var listAdjacent = [];
        for (int tile = 0; tile < gridSize * gridSize; tile++) {
          if (tiles[tile].isAdjacent && tile != previousTile) {
            listAdjacent.add(tile);
          }
        }

        //Update previous tile to prevent going back and forth
        previousTile = emptyTileIndex;

        //Swap empty tile with any adjacent tile (that's not the previous one)
        int randomTileIndex = listAdjacent[random.nextInt(listAdjacent.length)];
        swapTiles(randomTileIndex, userAction: false);
      }
    } while (checkVictory()); //Swap tiles until the map is not already finished
  }

  // Restart the game (after a win or on button press)
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

  //Update tiles when image or grid size is changed
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

    //Copy the base image grid
    baseImageGrid = GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        shrinkWrap: true,
        crossAxisCount: gridSize,
        children: tiles.map((tile) => tile.croppedImageTile()).toList());
  }

  // Add the "isAdjacent" attribute on the adjacent tiles to the empty one, whenever a move is made
  void updateAdjacentTiles() {
    //Update adjacent tiles
    for (int i = 0; i < tiles.length; i++) {
      tiles[i].isAdjacent = isAdjacent(i);
    }
  }

  // Swap the tile with the "src" index in the "tiles" List with the empty one
  void swapTiles(int src, {bool userAction = true}) {
    if (!playing) {
      showSnackbar("Appuyez sur PLAY pour commencer", context,
          const Duration(milliseconds: 500));
      return;
    }

    //Check if valid tile to swap (above, below, left or right)
    if (tiles[src].isAdjacent) {
      setState(() {
        //Swap tiles in list
        var temp = tiles[src];
        tiles[src] = tiles[emptyTileIndex];
        tiles[emptyTileIndex] = temp;

        //Save undo actions
        if (userAction) {
          previousEmptyTileIndexes.add(emptyTileIndex);
          //Max 5 undo actions
          while (previousEmptyTileIndexes.length > 5) {
            previousEmptyTileIndexes.removeAt(0);
          }
        }
        //Update new empty pos
        emptyTileIndex = src;

        //Update adjacent tiles
        updateAdjacentTiles();

        //Update count
        if (userAction) {
          nbCoups++;
        }

        // Check for victory if the user is playing
        if (userAction && checkVictory()) {
          //Show confettis
          _confettisController.play();

          //Show popup
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Victoire !'),
                // ignore: prefer_interpolation_to_compose_strings
                content: Text(
                    "Félicitations, vous avez gagné en $nbCoups coups et $_elapsedTime !"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      restart();

                      //Stop confettis
                      _confettisController.stop();
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

  // Undo the previous action (swap back the empty tile with its previous position)
  void undoAction() {
    //Make sure we can undo
    if (previousEmptyTileIndexes.isEmpty) {
      return;
    }

    //Undo action
    swapTiles(previousEmptyTileIndexes[previousEmptyTileIndexes.length - 1],
        userAction: false);
    nbCoups--;

    //Remove last action
    previousEmptyTileIndexes.removeLast();
  }

  // Check if the actual grid is the same as the correct image grid
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

  //Select an image from the gallery or the camera
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

  //Check if a tile is adjacent to the empty tile
  bool isAdjacent(int src) {
    bool sameLine = src ~/ gridSize == emptyTileIndex ~/ gridSize;
    bool sameColumn = src % gridSize == emptyTileIndex % gridSize;

    bool leftOrRight =
        sameLine && (src == emptyTileIndex - 1 || src == emptyTileIndex + 1);
    bool aboveOrBelow = sameColumn &&
        (src == emptyTileIndex - gridSize || src == emptyTileIndex + gridSize);

    return (aboveOrBelow || leftOrRight);
  }

  // Create a tile widget with click handler from tile
  Widget createTileWidgetFrom(Tile tile, int index) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        //Try to swap tiles on tap
        swapTiles(index);
      },
    );
  }

  // BUILD FUNCTION

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
                  Offstage(
                    offstage: showBaseImage,
                    child: GridView.count(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      shrinkWrap: true,
                      crossAxisCount: gridSize,
                      children: tiles.asMap().entries.map((entry) {
                        return createTileWidgetFrom(entry.value, entry.key);
                      }).toList(),
                    ),
                  ),
                  Offstage(
                    offstage: !showBaseImage,
                    child: baseImageGrid,
                  ),
                  ConfettiWidget(
                    confettiController: _confettisController,
                    blastDirectionality: BlastDirectionality.explosive,
                    emissionFrequency: 0.05, // how often it should emit
                    numberOfParticles: 20, // number of particles to emit
                    gravity: 0.05, // gravity - or fall speed
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // manually specify the colors to be used
                  ),
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
                            label:
                                "${((nbMelange / (gridSize * gridSize) - 1) * 100).round()}%",
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
          Visibility(
            visible: !playing,
            //Undo Button
            replacement: MyFloatingButton(
              icon: Icons.undo,
              onPressed: previousEmptyTileIndexes.isEmpty ? null : undoAction,
              disabled: previousEmptyTileIndexes.isEmpty,
              color: Colors.blue.shade600,
            ),
            //Image gallery button
            child: MyFloatingButton(
              icon: Icons.camera,
              onPressed: () {
                if (!kIsWeb) {
                  //Ask user to go to Gallery or Camera
                  showCustomDialog(
                    context,
                    title: "Choix de la source",
                    leftBtnText: "Gallerie",
                    leftBtnPressed: () => selectImage(ImageSource.gallery),
                    rightBtnText: "Caméra",
                    rightBtnPressed: () => selectImage(ImageSource.camera),
                  );
                } else {
                  showSnackbar(
                      "L'import d'image ne marche que sur mobile", context);
                }
              },
              color: Colors.blue.shade600,
            ),
          ),
          //Main btn (play or restart)
          MyFloatingButton(
            icon: playing ? Icons.replay : Icons.play_arrow,
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
          ),
          Visibility(
            visible: playing,
            //Base image toggle button
            child: MyFloatingButton(
              icon: showBaseImage ? Icons.visibility_off : Icons.visibility,
              onPressed: () {
                setState(() {
                  showBaseImage = !showBaseImage;
                });
              },
              color: Colors.blue.shade600,
            ),
          ),
          Visibility(
            visible: !playing,
            child: MyFloatingButton(
              icon: Icons.language,
              onPressed: () {
                setState(() {
                  //Reload image
                  image = Image.network(
                      "$networkImageUrl?random=${random.nextDouble()}");
                  updateTiles();
                });
              },
              color: Colors.blue.shade600,
            ),
          )
        ],
      ),
    );
  }
}
