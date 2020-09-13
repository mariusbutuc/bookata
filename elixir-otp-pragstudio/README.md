# Developing With Elixir/OTP

Journey of learning guided by the [Developing With Elixir/OTP](https://pragmaticstudio.com/elixir) video course.

### Lessons

- [x] 1. Introduction
- [x] 2. Create Mix Project
- [x] 3. High-Level Transformations
- [x] 4. Pattern Matching
- [x] 5. Immutable Data
- [x] 6. Function Clauses
- [ ] 7. Advanced Pattern Matching
- [ ] 8. Pattern Matching Maps
- [ ] 9. Serving Files
- [ ] 10. Module Attributes
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

### Takeaways

- Start from first principles: learn about the anatomy of the HTTP request and response.
- Thinking about programming:
  - OOP: Objects + calling methods on them to change their state
  - FP: Transforming data with functions
- Accessing values in a map
  - Square-bracket syntax: (+) works with all maps, (?) returns `nil` for missing keys
  - Dot notation: (+) more strict (`KeyError`), (-) only works for keys that are atoms
- [`String.length/1`] versus [`byte_size/1`].
- In Elixir, we use `if` clauses less often comparative to imperative languages.
  Instead, it is more _idiomatic_ to control the flow of the program using
  pattern matching and functions. We prefer using pattern matching as an
  alternative to `if`/`else` conditionals, by writing short, _declarative_
  functions.
- In Elixir _parlance_, function clauses is what we call multiple function
  definitions that share the same name and arity.

### Extracurricular

- Add a few unit tests to (a) improve confidence in refactoring and (b) reduce manual testing.
- Start exploring [`cortex`] to make TDD fun again.

  [`byte_size/1`]: https://hexdocs.pm/elixir/Kernel.html?#byte_size/1
  [`cortex`]: https://hex.pm/packages/cortex
  [`string.length/1`]: https://hexdocs.pm/elixir/String.html#length/1
