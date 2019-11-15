const SCRIPTS = require("./scripts");

/**
 * Dominant writing direction
 * Write a function that computes the dominant writing direction in a string of
 * text. Remember that each script object has a `direction` property that can
 * be `"ltr"` (left to right), `"rtl"` (right to left), or `"ttb"` (top to
 * bottom).
 *
 * The dominant direction is the direction of a majority of the characters that
 * have a script associated with them. The `characterScript` and `countBy`
 * functions defined earlier in the chapter are probably useful here.
 *
 * @param {string} text string to compute the dominant writing direction for
 */
// Version 1: Reuse _characterScript & _countBy as they are in the book.
function dominantDirection(text) {
  const noScript = { name: "none", count: 0 };

  let scripts = _countBy(text, char => {
    let script = _characterScript(char.codePointAt(0));
    return script ? script.name : "none";
  }).filter(({ name }) => name != "none");

  let dominantScriptGroup = scripts.reduce((dominantScript, currentScript) => {
    return currentScript.count > dominantScript.count
      ? currentScript
      : dominantScript;
  }, noScript);

  let dominantScript = SCRIPTS.find(
    script => script.name === dominantScriptGroup.name
  );

  return dominantScript.direction;
}

console.log(dominantDirection("Hello!"));
// → ltr
console.log(dominantDirection("Hey, مساء الخير"));
// → rtl

/**
 * Given a character code, find the corresponding script (if any).
 *
 * Source: https://eloquentjavascript.net/05_higher_order.html#c_Q8918ecfHn
 *
 * @param {number} code The character code
 * @returns {Script | null} The script that the character code belongs to
 *
 * Example
 *    > _characterScript(121)
 *    { name: 'Latin',
 *      ranges:
 *       [ [ 65, 91 ],
 *         [ 97, 123 ],
 *         [ 170, 171 ],
 *         [ 186, 187 ],
 *         [ 192, 215 ],
 *         [ 216, 247 ],
 *         [ 248, 697 ],
 *         [ 736, 741 ],
 *         [ 7424, 7462 ],
 *         [ 7468, 7517 ],
 *         [ 7522, 7526 ],
 *         [ 7531, 7544 ],
 *         [ 7545, 7615 ],
 *         [ 7680, 7936 ],
 *         [ 8305, 8306 ],
 *         [ 8319, 8320 ],
 *         [ 8336, 8349 ],
 *         [ 8490, 8492 ],
 *         [ 8498, 8499 ],
 *         [ 8526, 8527 ],
 *         [ 8544, 8585 ],
 *         [ 11360, 11392 ],
 *         [ 42786, 42888 ],
 *         [ 42891, 42927 ],
 *         [ 42928, 42936 ],
 *         [ 42999, 43008 ],
 *         [ 43824, 43867 ],
 *         [ 43868, 43877 ],
 *         [ 64256, 64263 ],
 *         [ 65313, 65339 ],
 *         [ 65345, 65371 ] ],
 *      direction: 'ltr',
 *      year: -700,
 *      living: true,
 *      link: 'https://en.wikipedia.org/wiki/Latin_script' }
 */
function _characterScript(code) {
  for (let script of SCRIPTS) {
    let codeBelongsToScript = script.ranges.some(([from, to]) => {
      return code >= from && code < to;
    });

    if (codeBelongsToScript) {
      return script;
    }
  }
  return null;
}

/**
 * Count the numbers of `items` that fit in groups named by the `groupName`
 * function.
 *
 * Source: https://eloquentjavascript.net/05_higher_order.html#c_nau/OQcf6J
 *
 * Example
 *    > _countBy([1, 2, 3, 4, 5], n => n > 2)
 *    [ { name: false, count: 2 }, { name: true, count: 3 } ]
 *
 * @param {Array} items Array of items to be grouped and counted
 * @param {Function} groupName Function who's return value will name the group
 * @returns {Array<Object>} Array of objects with a `name` of the group and the
 *  `count` of the items contained in the group.
 */
function _countBy(items, groupName) {
  let counts = [];
  for (let item of items) {
    let name = groupName(item);
    let known = counts.findIndex(c => c.name == name);
    if (known == -1) {
      counts.push({ name, count: 1 });
    } else {
      counts[known].count++;
    }
  }
  return counts;
}
