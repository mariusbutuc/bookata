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

> A solid understanding of asynchronous behavior is essential for the modern JavaScript engineer.

### [`Promise`]

An object that represents whether the async operation is pending, has been completed, or has failed.

- `then()` » invoke the callback if the previous operation was successful
- `catch()` » invoke the callback if the `fetch` did not resolve successfully

### Async/Await

The syntax of [`async` functions] looks (more) like code found in synchronous functions.

- `async` » makes the function asynchronous that can wait for promises to resolve before executing the code any further.
- `await` » wait for the promise to resolve first.
- `try…catch` » surround the promise call to handle any errora that may occur due to an unresolved promise.

## Classes

- Initially, the React library leaned heavily on [classes] to construct user interface components.
- Nowadays, React is beginning to move away from classes, towards using functions to construct components.
- Classes are still prevalent, particularly in legacy React code, as well as in the JavaScript world at large.
- JavaScript uses [`prototypical inheritance`], a.k.a. `prototypal inheritance`.

  - Three different kinds of prototypal inheritance

    1. Concatenative inheritance: `Object.assign()`, mixins, etc.
    2. Prototype delegation: `Object.create()`, `new`, `Object.prototype`, etc.

       > If a property is not found on the object, the lookup is delegated to the delegate prototype. […]
       > When most people think of prototypal OO in JavaScript, they think of prototype delegation.

    3. Functional inheritance: factory function, etc.

## ES6 Modules

- Reusable code, avoiding variable collision.
- Stored in separate files, one per module.
- `export` one or multiple objects, functions, primitives etc. — any JS type basically.
- `export default` can be used to export a single main type.
- Consumed using `import`: either into a dingle variable or leveraging object destructuring.
- Aliases can be used to scope module variables locally under different variable names.
- Alternatively, `*` can be used to import everything into a single variable.

### CommonJS

- The ES6 module `import` / `export` is not yet fully supported by all browsers _or_ by Node.
  - Babel supports it though.
- CommonJS is the module pattern supported by all versions of Node.
  - Here, `module.exports` and `require` are used to export and import respectively.

[`async` functions]: async_await.js
[`promise`]: promises.js
[`prototypical inheritance`]: https://medium.com/javascript-scene/e4cd0a7562e9
[a constant]: const.js
[babel repl]: https://babeljs.io/repl
[classes]: classes.js
[different syntax options & anatomy]: functions.js
[kangax compatibility table]: http://kangax.github.io/compat-table/esnext/
[list matching]: list_matching.js
[restructuring]: object_restructuring.js
[spread operator]: spread_operator.js
[template strings]: template_strings.js
[used for objects]: https://github.com/tc39/proposal-object-rest-spread
