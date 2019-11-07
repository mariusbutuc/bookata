/**
 * Everything
 *
 * Analogous to the `some` method, arrays also have an `every` method. This one
 * returns `true` when the given function returns `true` for every element in
 * the array. In a way, `some` is a version of the `||` operator that acts on
 * arrays, and `every` is like the `&&` operator.
 *
 * Implement `every` as a function that takes an array and a predicate function
 * as parameters. Write two versions, one using a loop and one using the `some`
 * method.
 *
 * @param {number[]} array Values to verify if every element satisfies the test
 * @param {Function} test Predicate function to test values
 * @return {boolean} Does the `test` predicate function return `true` for all
 *  the values in the given `array`?
 */
function every(array, test) {
  for (let element of array) {
    if (!test(element)) return false;
  }
  return true;
}

function every(array, test) {
  return !array.some(element => {
    return !test(element);
  });
}

console.log(every([1, 3, 5], n => n < 10));
// → true
console.log(every([2, 4, 16], n => n < 10));
// → false
console.log(every([], n => n < 10));
// → true
