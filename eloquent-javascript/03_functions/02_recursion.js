/**
 * Recursion
 *
 * We’ve seen that `%` (the remainder operator) can be used to test whether a
 * number is even or odd by using `% 2` to see whether it’s divisible by two.
 * Here’s another way to define whether a positive whole number is even or odd:
 *  * Zero is even.
 *  * One is odd.
 *  * For any other number N, its evenness is the same as N - 2.
 *
 * Define a recursive function `isEven` corresponding to this description.
 * The function should accept a single parameter (a positive, whole number) and
 * return a Boolean.
 *
 * Test it on 50 and 75.
 * See how it behaves on -1. Why?
 * Can you think of a way to fix this?
 */

/**
 * Test whether a number is even or odd.
 *
 * @param {number} number a number that we "expect" to be positive and whole
 * @return {boolean}
 */
function isEven(number) {
  positiveInteger = _guardPositiveInteger(number);

  if (!positiveInteger) {
    return false;
  } else if (positiveInteger === 0) {
    return true;
  } else if (positiveInteger === 1) {
    return false;
  } else {
    return isEven(positiveInteger - 2);
  }
}

/**
 * Convert a value into a positive integer. Return `NaN` if it is impossible.
 *
 * @param {any} anything any value
 * @return {number | NaN} a positive integer if the conversion was possible,
 *    otherwise NaN
 */
function _guardPositiveInteger(anything) {
  positiveInteger = Math.abs(parseInt(anything));

  if (Number.isInteger(positiveInteger)) {
    return positiveInteger;
  } else {
    console.log(`
      Nice try, ${anything} is definitely not even. 😉
      Please try a whole number (integer).`);
    return NaN;
  }
}

console.log(isEven(50));
// → true
console.log(isEven(75));
// → false
console.log(isEven(-1));
// → ?? -> false
console.log(isEven("bananas"));
// →
// →       Nice try, bananas is definitely not even. 😉
// →       Please try a whole number (integer).
// → false
