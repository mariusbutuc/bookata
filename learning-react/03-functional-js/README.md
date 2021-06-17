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

### Data Transformations

- FP is all about [transforming data] from one form to another.
- Two core functions, `map` and `reduce`, significantly facilitate creating one dataset from another.

  - `Array.map`

    - Use case: Create a pure function that changes one object in an array of objects.

      - ⚠️ Ensure the changes are on the new array and not to the original.
      - Since the arguments (`schools` and `school`) are passed in as references, something like

        ```js
        school.name = newName;
        ```

        would still mutate the original data.

      - Therefore using `Array.map` alone is not a guarantee for immutability.

    - Use case: Transform object structure for more refined semantics, or an array, with the help of `Object.keys`

      ```js
      Object.keys(dehydratedObject).map(…)
      ```

  - `Array.reduce`

    - Used to turn collections/arrays into primitives and other objects.
      > If the [2<sup>nd</sup>, optional `initialValue` argument][reduce initial value] is not supplied, the first element in the array will be used as the initial `accumulator` value and skipped as `currentValue`.
    - Use `Array.reduceRight` if we need to start reducing from the end of the array.

    - Use cases:
      - Find the maximum value in an array.
      - Transform an array into a [hash]/indexed lookup.
      - Deduplicate values in an array.

- Other useful `Array` functions that do not mutate their arguments:
  - `Array.join`
  - `Array.filter`
    - A _predicate_ is a function that always returns a Boolean value: `true` or `false`.
    - To be preferred over `Array.pop` or `Array.splice` to remove an element from an array, as it does not mutate data.

### Higher-order Functions

- [Higher-order functions] are functions that can manipulate other functions:

  - Functions that take functions in as arguments

    - e.g., `Array.map`, `Array.filter`, and `Array.reduce`

  - Functions that return functions

    - can help handle the complexities associated with asynchronicity in JavaScript.

  - Functions that both intake and return functions

- Currying

  > A [curried function] is a function that takes multiple arguments _one at a time_. […]

### Recursion

> Creating [functions that recall themselves]. […] A replacement for loops.

Use cases:

- Recursion is a pattern that works particularly well with asynchronous processes.
- Recursion is a good technique for searching data structures.

[_what_ should happen]: http://wiki.c2.com/?DeclarativeProgramming
[curried function]: https://medium.com/javascript-scene/curry-and-function-composition-2c208d774983
[declarative programs]: declarative.js
[functions that recall themselves]: recursion.js
[functions]: functions.js
[hash]: https://en.wikipedia.org/wiki/Hash_function
[higher-order functions]: higher-order_functions.js
[immutable]: immutable.js
[imperative programs]: imperative.js
[pure functions]: pure_functions.js
[reduce initial value]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce#parameters
[transforming data]: data_transformations.js
[λ-calculus]: https://turing100.acm.org/lambda_calculus_timeline.pdf
