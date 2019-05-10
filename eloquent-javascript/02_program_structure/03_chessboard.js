/**
 * Chessboard
 *
 * Write a program that creates a string that represents an 8×8 grid, using
 * newline characters to separate lines. At each position of the grid there is
 * either a space or a "#" character. The characters should form a chessboard.
 *
 * Passing this string to `console.log` should show something like this:
 *
 *  # # # #
 * # # # #
 *  # # # #
 * # # # #
 *  # # # #
 * # # # #
 *  # # # #
 * # # # #
 *
 * When you have a program that generates this pattern, define a binding
 * `size = 8` and change the program so that it works for any `size`, outputting
 * a grid of the given width and height.
 */

const white = " ";
const black = "#";

let size = 8;
let board = "";
for (let rowIndex = 0; rowIndex < size; rowIndex++) {
  let row = "";

  if (rowIndex % 2 === 0) {
    // start with white
    for (let columnIndex = 0; columnIndex < size; columnIndex++) {
      if (columnIndex % 2 === 0) {
        row += white;
      } else {
        row += black;
      }
    }
  } else {
    // start with black
    for (let columnIndex = 0; columnIndex < size; columnIndex++) {
      if (columnIndex % 2 === 0) {
        row += black;
      } else {
        row += white;
      }
    }
  }

  board += `${row}\n`;
}

// Really wish I had access to arrays and functions by now…
console.log(board);
