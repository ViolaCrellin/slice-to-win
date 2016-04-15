# Odd-One-Out-Game
Inspired by Codility Training

## The Rules:

Two players are faced with an array of numbers such as:

[23, 6, 88, 24, 1, 4, 90, 46, 7, 12, 26, 3, 2, 57, 21, 5]

Each player slices away at the array, removing runs of numbers from the array in turn.

They can only slice runs of consecutive numbers that add up to an even number. They can also slice single even numbers from the array.

The idea is to leave your opposition with no choice but to take the last odd number.

For example:

Player 1 slices the numbers 12 and 26. The slice position is [9, 10]
The board now looks like:

[23, 6, 88, 24, 1, 4, 90, 46, 7, 3, 2, 57, 21, 5]

Player 2 slices 4, 90, 46. The slice position is [5, 7]
The board now looks like:

[23, 6, 88, 24, 1, 7, 3, 2, 57, 21, 5]

Player 1 slices 57, 21, 5. The slice position is [8, 10]
The board now looks like:

[23, 6, 88, 24, 1, 7, 3, 2]

Player 2 slices 1, 7, 3. The slice position is [4, 6]
The board now looks like:

[23, 6, 88, 24, 2]

Player 1 slices 6, 88, 24, 2. The slice position is [1, 4]
The board now looks like:

[23]

Player 2 is forced to take the odd number and therefore loses. Player 1 wins.


The Codility Training exercise asks that your program returns the first slice taken that would cause Player1 to win the game.

If there is no 1st slice that leads to you winning the game - considering that Player2 is playing optimally - you must return "NO SOLUTION"

If in event of there being more than one possible first slice that will lead to Player1 winning the game, you must return the slice that would have the smallest sum. 

## Where I'm at:

I've started solving this for codility's test, but will probably expand it into a game where you can play (not optimally) against a computer playing optimally.

At the moment I'm investigating the problem more than coding my solution to it.

An epic refactor is on the cards...
