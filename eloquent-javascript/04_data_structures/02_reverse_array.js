/**
 * Reversing an array
 *
 * Arrays have a `reverse` method that changes the array by inverting the order
 * in which its elements appear. For this exercise, write two functions,
 * `reverseArray` and `reverseArrayInPlace`. The first, `reverseArray`, takes an
 * array as argument and produces a _new_ array that has the same elements in
 * the inverse order. The second, `reverseArrayInPlace`, does what the reverse
 * method does: it _modifies_ the array given as argument by reversing its
 * elements. Neither may use the standard `reverse` method.
 *
 * Thinking back to the notes about side effects and pure functions in the
 * **previous chapter**, which variant do you expect to be useful in more
 * situations? Which one runs faster?
 */

/**
 * Reverse an array. Produce a _new_ array.
 *
 * @param {Array<any>} array an array of elements
 * @returns {Array<any>} a _new_ array that has the same elements as the
 *    original `array`, but in the inverse order.
 */
function reverseArray(array) {
  reversedArray = [];

  for (let element of array) {
    reversedArray.unshift(element);
  }

  return reversedArray;
}

/**
 * Reverse an array. Done in the same way that `Array.prototype.reverse()` [1]
 * does: _modify_ the array given as an argument by reversing its elements.
 *
 *   [1]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reverse
 *
 * @param {Array<any>} array an array of elements
 * @returns {Array<any>} the original array that is _modified_ by reversing its
 *    elements.
 */
function reverseArrayInPlace(array) {
  // Your code here.
}

console.log(reverseArray(["A", "B", "C"]));
// → ["C", "B", "A"];

let arrayValue = [1, 2, 3, 4, 5];
reverseArrayInPlace(arrayValue);
// console.log(arrayValue);
// → [5, 4, 3, 2, 1]
