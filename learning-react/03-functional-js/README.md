# Functional Programming with JavaScript

- Functional programming (FP) techniques are being used more and more in JavaScript (JS) projects, particularly React projects.
- History and (some) terminology:
  - 1930s: lambda calculus, or [λ-calculus]
  - Higher-order functions: functions that either take or return other functions.
    > If you see more than one arrow used during a function declaration, this means that you're using a higher-order function.
- FP is supported in JS, since JS [functions] are first-class citizens.
  - Functions are data: they can be saved, retrieved, or flow through the app just like variables.

## Imperative vs Declarative

> Declarative programming is a style of programming where applications are structured in a way that prioritizes describing [_what_ should happen] over defining _how_ it should happen.

- Consequently, [imperative programs] tend to need a substantially larger number of comments in order to understand what's going on.
- Consequently, [declarative programs] tend to be more readable and, thus, easier to reason about. The code itself, the syntax itself describes what should happen, while the details of how things happen are abstracted away. Hence the application becomes arguably easier to scale.
- React is declarative.

## Core concepts of functional programming

### Immutability

- In a functional program, data is [immutable]. It never changes.
- _Mutability_: In JavaScript, function arguments are references to the actual data.
  - JavaScript standard modules can mix mutating functions (`Array.push`) together with immutable functions (`Array.concat`).
- Instead of changing the original data structures, we build changed copies of those data structures and use them instead.

- `Object.assign` is the copy machine:

  1. take a blank object,
  2. copy the original object,
  3. overwrite the properties that need to be changed.

  ```js
  Object.assign({}, color, { rating });
  ```

- Alternatively, the spread operator (`...`) can be used to

  1. copy the original object into a new object
  2. overwrite the properties that need to be changed.

  ```js
  { ...color, rating } // Objects
  [...list, { title }] // Arrays
  ```

  ⚠️ As well as adding new elements to an array, the spread operator can also add _new_, inexistent properties to an object.

  Contrast this behaviour with the "update operator" from other languages e.g., Elixir: `%Foo{oldfoo | bar: "new value"}`.

### Pure functions

- [Pure functions] are functions that:

  - Return a value (this value can also be a function) that is computed based on its argument(s) alone.
  - Treat their arguments as immutable data.
  - Do not cause side effects, like setting global variables or changing anything else about the application's state.

- Pure functions are naturally _testable_.

  - They do not change anything about their environment, or "world".
  - Consequently, they do not require a complicated test setup or teardown.

- In React, the UI is expressed with pure functions.

  - It does not mutate the DOM.
  - It's the responsibility of some other part of the application to use that element to change the DOM.

[_what_ should happen]: http://wiki.c2.com/?DeclarativeProgramming
[declarative programs]: declarative.js
[functions]: functions.js
[immutable]: immutable.js
[imperative programs]: imperative.js
[pure functions]: pure_functions.js
[λ-calculus]: https://turing100.acm.org/lambda_calculus_timeline.pdf
