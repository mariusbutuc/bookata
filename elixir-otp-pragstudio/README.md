# Developing With Elixir/OTP

Journey of learning guided by the [Developing With Elixir/OTP] video course.

### Lessons

- [x] 1. Introduction
- [x] 2. Create Mix Project
- [x] 3. High-Level Transformations

  - Start from first principles: the anatomy of the HTTP request and response.
  - Thinking about programming:
    - OOP: Objects + calling methods on them to change their state
    - FP: Transforming data with functions

- [x] 4. Pattern Matching

  - Add a few unit tests to
    - (a) improve confidence in refactoring and
    - (b) reduce manual testing.
  - Start exploring [`cortex`] to make TDD fun again.

- [x] 5. Immutable Data

  - Accessing values in a map
    - Square-bracket syntax: (+) works with all maps, (?) returns `nil` for missing keys
    - Dot notation: (+) more strict (`KeyError`), (-) only works for keys that are atoms
  - [`String.length/1`] versus [`byte_size/1`].

- [x] 6. Function Clauses

  - In Elixir, we use `if` clauses less often comparative to imperative languages.
    Instead, it is more _idiomatic_ to control the flow of the program using
    pattern matching and functions. We prefer using pattern matching as an
    alternative to `if`/`else` conditionals, by writing short, _declarative_
    functions.
  - In Elixir _parlance_, function clauses is what we call multiple function
    definitions that share the same name and arity.

- [x] 7. Advanced Pattern Matching

  - The string concatenation operator ([`<>`]) can be used to match the beginning
    of a string in a pattern match. Additionally, the rest of the string is bound
    to the given variable.

- [x] 8. Pattern Matching Maps

  - A technique used extensively in Elixir. Very powerful.
  - As always, there are multiple ways to do the same thing. And it's often
    simply a matter of preference.
  - [`Regex.named_captures/3`] are neat! Wondering if the resulting map has
    string keys because the captures can be bound to names that would be invalid
    atoms.

- [x] 9. Serving Files

  - Elixir parlance/data type: a _tuple_ represents an ordered collection of
    values. They typically hold 2-4 values.
  - Many Elixir built-in functions use this _idiom_: return a tuple to
    distinguish between success/error outcomes.
  - _Design decision:_ a [`case`] expression is just another way to
    conditionally run code based on pattern matches. Multi-clause functions are
    an alternative. Let's write it out and see… Same output, but which one is
    better™? There's no right and wrong answer. The choice you make will vary
    depending on the situation and your personal preference.

- [x] 10. Module Attributes

  - Set at the top level of a module.
  - Used to associate metadata with the module.
  - Reserved module attributes:
    - `@moduledoc` — document modules
    - `@doc` — document functions
  - Custom module attributes — can be used to store constants.

- [ ] 11. Organizing Code
- [ ] 12. Modeling With Structs
- [ ] 13. Matching Heads and Tails
- [ ] 14. Recursion
- [ ] 15. Slicing and Dicing with Enum
- [ ] 16. Comprehensions
- [ ] 17. A Peek At Phoenix
- [ ] 18. Test Automation
- [ ] 19. Rendering JSON
- [ ] 20. Web Server Sockets
- [ ] 21. Concurrent, Isolated Processes
- [ ] 22. Sending and Receiving Messages
- [ ] 23. Asynchronous Tasks
- [ ] 24. Stateful Server Processes
- [ ] 25. Refactoring Toward GenServer
- [ ] 26. OTP GenServer
- [ ] 27. Another GenServer
- [ ] 28. Linking Processes
- [ ] 29. Fault Recovery with OTP Supervisors
- [ ] 30. Final OTP Application
- [ ] Next Steps
- [ ] Evaluation

  [`<>`]: https://hexdocs.pm/elixir/Kernel.html#%3C%3E/2
  [`byte_size/1`]: https://hexdocs.pm/elixir/Kernel.html?#byte_size/1
  [`case`]: https://hexdocs.pm/elixir/Kernel.SpecialForms.html#case/2
  [`cortex`]: https://hex.pm/packages/cortex
  [`Regex.named_captures/3`]: https://hexdocs.pm/elixir/Regex.html#named_captures/3
  [`String.length/1`]: https://hexdocs.pm/elixir/String.html#length/1
  [Developing With Elixir/OTP]: (https://pragmaticstudio.com/elixir)
