/**
 * A list
 *
 * Objects, as generic blobs of values, can be used to build all sorts of data
 * structures. A common data structure is the _list_ (not to be confused with
 * array). A list is a nested set of objects, with the first object holding a
 * reference to the second, the second to the third, and so on.
 *
 * ```js
 * let list = {
 *   value: 1,
 *   rest: {
 *     value: 2,
 *     rest: {
 *       value: 3,
 *       rest: null
 *     }
 *   }
 * };
 * ```
 *
 * The resulting objects form a chain.
 *
 * A nice thing about lists is that they can share parts of their structure. For
 * example, if I create two new values `{value: 0, rest: list}` and
 * `{value: -1, rest: list}` (with `list` referring to the binding defined
 * earlier), they are both independent lists, but they share the structure that
 * makes up their last three elements. The original list is also still a valid
 * three-element list.
 *
 * Write a function `arrayToList` that builds up a list structure like the one
 * shown when given `[1, 2, 3]` as argument. Also write a `listToArray` function
 * that produces an array from a list. Then add a helper function `prepend`,
 * which takes an element and a list and creates a new list that adds the
 * element to the front of the input list, and `nth`, which takes a list and a
 * number and returns the element at the given position in the list (with zero
 * referring to the first element) or `undefined` when there is no such element.
 *
 * If you haven’t already, also write a recursive version of `nth`.
 */

/**
 * Build up a list structure from a given array.
 *
 * @param {Array<any>} array an array with elements of any type
 * @return {object} the list object
 */
function arrayToList(array) {
  let listObject = null;

  for (let arrayIndex = array.length - 1; arrayIndex >= 0; arrayIndex--) {
    let element = array[arrayIndex];
    listObject = prepend(element, listObject);
  }

  return listObject;
}

/**
 * Produce an array from a given list object
 *
 * @param {object} list a list object
 * @return {Array<any>} the array representation of the given list
 */
function listToArray(list) {
  let array = [];

  array = _listToArray(list, array);

  return array;
}

function _listToArray({ value: head, rest: tail }, array) {
  array.push(head);

  if (tail === null) {
    return array;
  } else {
    return _listToArray(tail, array);
  }
}

/**
 * Create a new list by adding the given element to the front of the input list.
 *
 * @param {any} element the element to be prepended to the input list
 * @param {object} list the list that the input element is prepended to
 * @return {object} the new list object
 */
function prepend(element, list) {
  return { value: element, rest: list };
}

/**
 * Given a `list` and a number, return the element at the given `position` in
 * the list (with zero referring to the first element) or `undefined` when there
 * is no such element.
 *
 * @param {object} list the list that may contain an element at the given
 *    `position`
 * @param {number} position the position from which to get an element from the
 *    `list`
 * @return {list_element | undefined} the list element residing at `position` or
 *    `undefined` if the position is not within the `list`
 */
function nth(list, position) {
  let element = null;

  if (position === 0) {
    element = list.value;
  } else if (list.rest === null) {
    element = undefined;
  } else {
    element = nth(list.rest, position - 1);
  }

  return element;
}

console.log(arrayToList([10, 20]));
// → {value: 10, rest: {value: 20, rest: null}}
console.log(listToArray(arrayToList([10, 20, 30])));
// → [10, 20, 30]
console.log(prepend(10, prepend(20, null)));
// → {value: 10, rest: {value: 20, rest: null}}
console.log(nth(arrayToList([10, 20, 30]), 1));
// → 20
console.log(nth(arrayToList([10, 20, 30]), 17));
// → undefined
