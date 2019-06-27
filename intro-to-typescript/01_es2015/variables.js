/**
 * ## `const` & `let`
 *
 * * Forget the existence of `var`
 * * Both `const` and `let` are block-scoped
 * * `const` cannot be re-declared
 *      * this does not make object immutable - Object.freeze() or immutable.js can be used for that
 */

let name = 'Steve';
name = 'Adam';

// console.log(name);
// » Adam



const constantName = 'Steve';
// constantName = 'Adam';
// TypeError: Assignment to constant variable.



const person = { data: ['hello'] };
person.data.push('something');

// console.log(person);
// » { data: [ 'hello', 'something' ] }



if (1 === 1) {
    let blockScopedName = 'Steve';
}

// console.log(blockScopedName);
// ReferenceError: blockScopedName is not defined

/**
 * ## Preferences:
 *
 *  1. Always use the `const` keyword for things that do not change
 *     e.g., when requiring libraries or modules in node.js.
 *
 *  2. Otherwise, always use `let` if you plan on re-assigning the variable.
 */
