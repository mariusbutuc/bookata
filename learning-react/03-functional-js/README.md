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

[_what_ should happen]: http://wiki.c2.com/?DeclarativeProgramming
[declarative programs]: declarative.js
[functions]: functions.js
[imperative programs]: imperative.js
[λ-calculus]: https://turing100.acm.org/lambda_calculus_timeline.pdf
