# Ruby Programming [↗][course]

![67%](https://progress-bar.dev/67)

> Power up with Ruby and get ready for Rails!

…or, how to get back up to speed with Ruby in ~23 days~ half a week or less.

## Modules

- [x] 1. Introduction
  - When installing Ruby, I prefer `asdf` over `rbenv`: can use this for Elixir and other languages as well.
- [x] 2. Running Ruby
  - [VS Code extensions](vs_code_extensions.md)
- [x] 3. Numbers and Strings
- [x] 4. Variables and Objects
  - Documentation with `RDoc` and `ri`
  - ⚠️ Effects of [passing by "object reference"](https://stackoverflow.com/a/10974116/341929)
- [x] 5. Self
  - The implicit receiver
- [x] 6. Methods
  - Lexical scoping
  - The Single Responsibility Principle
- [x] 7. Classes
  - Encapsulate state (instance variables) and behaviour (instance methods).
  - The constructor method, `initialize`, sets up the state for the instance/object.
- [x] 8. Attributes
  - Expose only as little internal/private state as possible to maintain high flexibility & adaptability to change.
- [x] 9. Arrays
  - One of Ruby's two (2) built-in collection classes.
  - An array is an _ordered_ list of object references.
- [x] 10. Objects Interacting

  - Goal of OOP:

    - identify _categories_ of things and
    - make _objects_ that represent those things.

  - Design:

    - Start from the interface I wish I could consume
    - **Tell, Don't Ask** principle

  - Heart of OOP:
    - Objects collaborating to accomplish something bigger.
    - More objects talking to more objects.

- [x] 11. Separate Source Files

  - "Document" classes with example usage code if `__FILE__ == $PROGRAM_NAME`, where:
    - `__FILE__` = the path of the current source file
    - `$PROGRAM_NAME` = the path of the Ruby program file being run

- [x] 12. Unit Testing

  - [RSpec](https://rspec.info/): domain-specific language for Behaviour Driven Development (BDD) written in Ruby. For describing/specifying/testing the behavior of objects.

- [x] 13. Conditionals and TDD

  - Benefits of writing _tests first_:

    - **Design** from the outside: before diving into implementation.
    - Start with a **measurable goal**: focus + know when you're done.
    - Always have safety nets in place: **confidence**, essential for being **productive**.

  - ⚠️ Interesting caveats on [RSpec: Settings mocks or stubs on _any instance_ of a class](https://github.com/rspec/rspec-mocks/blob/9ed1fdb/README.md#settings-mocks-or-stubs-on-any-instance-of-a-class)

- [x] 14. Modules

  > Writing **good code** isn't solely about writing code that **works** and **does what we expect**.  
  > Writing good code is also about reorganizing and **refactoring** our code as necessary to ensure that we **keep our code tidy**.  
  > **Clean code** is **easier to change**, and since change is inevitable, it's best if we're prepared for it.

- [x] 15. Blocks & Iterators

  > You'll find blocks _everywhere_ in good Ruby programs.

  - [`Enumerable`](https://ruby-doc.org/core-3.1.1/Enumerable.html)

  - Mastering [Ruby blocks & iterators](https://pragmaticstudio.com/ruby-blocks) is key in becoming an effective Ruby programmer.

- [ ] 16. Symbols and Structs
- [ ] 17. Hashes
- [ ] 18. Custom Iterators
- [ ] 19. Input/Output
- [ ] 20. Inheritance
- [ ] 21. Mixins
- [ ] 22. Distribution
- [ ] 23. Wrap Up

[course]: https://pragmaticstudio.com/courses/ruby
