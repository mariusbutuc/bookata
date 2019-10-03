/**
 * Bean counting
 *
 * You can get the Nth character, or letter, from a string by writing
 * `"string"[N]`. The returned value will be a string containing only one
 * character (for example, `"b"`). The first character has position 0, which
 * causes the last one to be found at position `string.length - 1`.
 * In other words, a two-character string has length 2, and its characters have
 * positions 0 and 1.
 *
 * Write a function `countBs` that takes a string as its only argument and
 * returns a number that indicates how many uppercase “B” characters there are
 * in the string.
 *
 * Next, write a function called `countChar` that behaves like `countBs`, except
 * it takes a second argument that indicates the character that is to be counted
 * (rather than counting only uppercase “B” characters). Rewrite `countBs` to
 * make use of this new function.
 */

/**
 * Count how many uppercase “B” characters there are in a given `string`.
 *
 * @param {string} string the string to be evaluated
 * @return {number} the number of uppercase “B” characters in the given string
 */
function countBs(string) {
  const characterToBeCounted = "B";
  let occurences = 0;

  for (
    let nthCharacter = 0;
    nthCharacter <= string.length - 1;
    nthCharacter++
  ) {
    if (string[nthCharacter] === characterToBeCounted) {
      occurences++;
    }
  }

  return occurences;
}

/**
 * Count how many `characterToBeCounted` characters are in a given `string`.
 *
 * @param {*} string
 * @param {*} characterToBeCounted
 */
function countChar(string, characterToBeCounted) {
  // Your code here.
}

console.log(countBs("BBC"));
// → 2
console.log(countChar("kakkerlak", "k"));
// → 4
