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
 * @param {any} left_comparable atomic value ot object to be compared
 * @param {any} right_comparable atomic value ot object to be compared
 * @returns {boolean} are the comparables deeply equal?
 */
function deepEqual(left_comparable, right_comparable) {
  let equalityTable = [];

  // TODO: Consider digesting this spaghetti code into something more refined.
  if (_isNull(left_comparable) && _isNull(right_comparable)) {
    equalityTable.push(true);
  } else if (_isNull(left_comparable) || _isNull(right_comparable)) {
    equalityTable.push(false);
  } else if ((_isObject(left_comparable)) && (_isObject(right_comparable))) {
    // deepEquality case
    let leftKeys = Object.keys(left_comparable)
    let rightKeys = Object.keys(right_comparable)

    for (let key of leftKeys) {
      if (_isIncluded(key, rightKeys) && (deepEqual(left_comparable[key], right_comparable[key]))) {
        equalityTable.push(true);
      } else {
        equalityTable.push(false);
      }
    }

  } else {
    // primitive values
    equalityTable.push(left_comparable === right_comparable);
  }

  return _areAllTrue(equalityTable);
}

function _isNull(value) {
  return (null === value)
}

function _isObject(value) {
  return ((null !== value) && (typeof (value) === 'object'))
}

function _isIncluded(element, array) {
  return (array.indexOf(element) >= 0)
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

console.log('\n*** Primitive values')
console.log('\n1. Numbers')
console.log(deepEqual(17, 17));
// → true
console.log(deepEqual(17, 18));
// → false
console.log(deepEqual(17, -17));
// → false

console.log('\n2. Strings')
console.log(deepEqual('foo', 'foo'));
// → true
console.log(deepEqual('foo', 'bar'));
// → false
console.log(deepEqual('17', 17));
// → false

console.log('\n3. Booleans')
console.log(deepEqual(true, true));
// → true
console.log(deepEqual(true, false));
// → false

console.log('\n*** Array (⚠️ internally represented as Objects)')
console.log(deepEqual([1, 'foo'], [1, 'foo']));
// → true
console.log(deepEqual([1, 'foo'], [1, 'bar']));
// → false
