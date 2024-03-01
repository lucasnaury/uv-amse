# tp2-Taquin

Here is our version of the Taquin game, our brain teaser by L.Naury and N.Kulkarni.

## The Game

### The goal

The goal is to build back the image after being shuffled, by moving tiles around and swaping a empty tile with regulare tiles so that at the end, the image no longer looks like a Picasso painting.

### The rules

You can can swap the empty tile with a regular one only if they share a side. They aren't any time or move limits.
The difficulty and number of tiles can be set by setting the slider to the wanted difficulty. One ***undo*** will be available after each move which will cancel the last move and remove 1 move from the counter.

### Start playing

After having selected the number of tiles and difficulty, you can start playing by clicking on the tile you want to swap the empty tile with. The stopwatch will automatically start. Should you want to restart a game, you cand do so by clicking on the restart button on the botton side of the screen. Once the taquin is completed, a pop up message will appear, informing you of your victory. The stopwatch will automaticaly stop, and you can start again by clicking on the restart button.


## Added functionalities (For Pr.Fabresse's eyes only)

Here is a non exhaustive list of the non-required functionnalities we have created:
- Choice of the difficulty
- Choice of the image (gallery, camera, randomly from the web)
- Stopwatch
- Number of moves
- Undo Button
- Button to see the original grid image
- Restart button
- End-of-game pop up
- Confettis at the end of the game

On the branch *** Solver-unsolved *** we have an unresolved version, which doesn't work all the time, of a solver showing the number of remaining moves needed to solve the Taquin puzzle, and this at each move (in theory).