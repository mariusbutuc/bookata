# A JavaScript syntax baseline, for React

- The [kangax compatibility table].

## Constants

- [A constant], declared with `const`, is a variable that cannot be overwritten.

## Lexical variable scope

- Lexical variable scope: `let` scopes the variable to the specific code block.

## Template Strings

- [Template strings], a.k.a. template literals or string templates, provide an alternative to string concatenation.

## Functions

- Used for repeatable tasks.

- [Different syntax options & anatomy]:

  - Function declaration, or function definition

    - Start with the `function` keyword, then the name of the function […].

    - Functions created using function declaration _are hoisted_.
      That is, invoking/calling a function before writing a function declaration is possible.

  - Function expression

    - Create a function as a variable.

    - Functions created using function expression _are **not** hoisted_.
      That is, invoking/calling a function before creating the function expression will cause an error (`ReferenceError`).

- Similar to other languages:

  - Functions can be passed in arguments, or (named) parameters, that become dynamic variables within the function body.
  - Function returns.
  - Default parameters, included in the ES6 spec.

- Arrow Functions: new feature of ES6.

  - Similar to function expressions
    - & simplified syntax
    - & protect the scope of (binding?) `this`.
  - One-liners have implicit `return` and need no curly braces.
  - Returning objects: wrap the returned object in parentheses. `SyntaxError` otherwise.
    ⚠️ These missing parentheses are the source of countless bugs in JavaScript and React apps!
  - ❓ Arrow functions protect the scope of `this` […] (yet) they do not block off the scope of `this`.

## Compiling JavaScript

- [Babel REPL]
- Automated build tools: webpack or Parcel.

## Objects and Arrays

- Destructuring objects
- Destructuring arrays

  - [list matching]: commas take the place of elements that should be skipped

- Object literal enhancement

  - [restructuring] or putting the object back together
  - also works to create object methods

- The [spread operator] `...`

  - Combine the contents of multiple arrays.
  - Clone an array to prevent it from beint mutated.
  - Get the remaining elements in an array.
  - Collect function arguments as an array.
  - Can also be [used for objects].

## Asynchronous JavaScript

- `Promise {<pending>}`

[a constant]: const.js
[babel repl]: https://babeljs.io/repl
[different syntax options & anatomy]: functions.js
[kangax compatibility table]: http://kangax.github.io/compat-table/esnext/
[list matching]: list_matching.js
[restructuring]: object_restructuring.js
[spread operator]: spread_operator.js
[template strings]: template_strings.js
[used for objects]: https://github.com/tc39/proposal-object-rest-spread
