/**
 * Minimum
 *
 * The previous chapter introduced the standard function `Math.min` that returns
 * its smallest argument. We can build something like that now.
 * Write a function `min` that takes two arguments and returns their minimum.
 */

/**
 * Calculate the minimum between two numbers
 *
 * @param {number} a The first number
 * @param {number} b The second number
 * @return {number} the smaller of the two arguments
 */
function min(a, b) {
  if (a <= b) {
    return a;
  } else {
    return b;
  }
}

console.log(min(0, 10));
// → 0
console.log(min(0, -10));
// → -10
