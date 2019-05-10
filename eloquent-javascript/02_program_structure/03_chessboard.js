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
/**
 * Variable naming decision
 *
 *   * `x` was chosen over `rowIndex` as it matches the x-axis
 *   * `y` was chosen over `columnIndex` as it matches the y-axis
 *
 * If the more verbose variable names are considered more readable / meaningful,
 * a search and replace should bring them back in use.
 */
for (let x = 0; x < size; x++) {
  let row = "";

  for (let y = 0; y < size; y++) {
    /**
     * Observation / optimization to reduce duplication and improve readability
     *
     * A "tile" on the chessboard is
     *   * white if (row = even && column = even) || (row = odd && column = odd)
     *   * black if (row = even && column = odd) || (row = odd && column = even)
     */
    if (((x % 2 === 0) && (y % 2 === 0)) || ((x % 2 !== 0) && (y % 2 !== 0))) {
      row += white;
    } else {
      row += black;
    }
  }

  board += `${row}\n`;
}

console.log(board);
