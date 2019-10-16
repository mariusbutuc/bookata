/**
 * Deep comparison
 *
 * The `==` operator compares objects by identity. But sometimes you’d prefer to
 * compare the values of their actual properties.
 *
 * Write a function `deepEqual` that takes two values and returns true only if
 * they are the same value or are objects with the same properties, where the
 * values of the properties are equal when compared with a _recursive call_ to
 * `deepEqual`.
 *
 * To find out whether values should be compared directly (use the `===`
 * operator for that) or have their properties compared, you can use
 * the `typeof` operator.
 * If it produces "`object`" for both values, you should do a deep comparison.
 * But you have to take one silly exception into account: because of a
 * historical accident, `typeof null` also produces "`object`".
 *
 * The `Object.keys` function will be useful when you need to go over the
 * properties of objects to compare them.
 */

/**
 * Compare objects or primitive/atomic values for (deep) equality.
 *
 * @param {any} leftComparable atomic value ot object to be compared
 * @param {any} rightComparable atomic value ot object to be compared
 * @returns {boolean} are the comparables deeply equal?
 */
function deepEqual(leftComparable, rightComparable) {
  let equalityTable = [];

  // TODO: Consider digesting this spaghetti code into something more refined.
  if (_isObject(leftComparable) && _isObject(rightComparable)) {
    // deepEquality case
    let leftProperties = Object.keys(leftComparable);
    let rightProperties = Object.keys(rightComparable);

    for (let property of leftProperties) {
      if (
        _isIncluded(property, rightProperties) &&
        deepEqual(leftComparable[property], rightComparable[property])
      ) {
        equalityTable.push(true);
      } else {
        equalityTable.push(false);
      }
    }
  } else {
    // primitive values
    equalityTable.push(leftComparable === rightComparable);
  }

  return _areAllTrue(equalityTable);
}

function _isObject(value) {
  // Hint: Your test for whether you are dealing with a real object will look
  //       something like `typeof x == "object” && x != null`.
  //
  // TODO: Refine understanding of "double equality (`==`)" relative to "triple
  //       equality (`===`)".
  //       1. Why is the `==` check good enough here?
  //       2. What semantics are missed in communication when relying more on ===?
  return null !== value && typeof value === "object";
}

function _isIncluded(property, properties) {
  return properties.indexOf(property) >= 0;
}

function _areAllTrue(truthTable) {
  return truthTable.every(truthValue => truthValue === true);
}

let obj = { here: { is: "an" }, object: 2 };
console.log(deepEqual(obj, obj));
// → true
console.log(deepEqual(obj, { here: 1, object: 2 }));
// → false
console.log(deepEqual(obj, { here: { is: "an" }, object: 2 }));
// → true
