# Notes

## ✅ 01. Welcome to Elixir for Programmers

## ✅ 02. Getting

## ✅ 03. Our First Project

```ex
h File.read/1
```

- In 99% of the common programming usecases, Erlang: `Binary` » Elixir: string

- Erlang/Elixir convention » tuples as return values:

  - success: `{:ok, value}`
  - error: `{:error, reason}`

Our usecase: if we cannot find our Dictionary list of words, we cannot do anything. We might as well blow up.

```ex
h File.read!/1
h File.read!("assets/words.txt")
```

Function id = name / arity

```ex
eg = "123\n456\n789\n"
```

- OOP: `eg.split()`
- FP: we only have functions and values.
  - function: values in, values out

```ex
String.split(eg)
# ["123", "456", "789"]

String.split(eg, ~r/\n/)
# ["123", "456", "789", ""]

String.split(eg, ~r/\n/, trim: true)
```

- In a functional language, every function returns a value

  - In Elixir, the return value is the last expression evaluated

  - Not necessarily the last lexical expression in the function, but the last thing to be executed

- Get inline warnings on save
  - Using NeoVim » Language Server Protocol

## ✅ 04. A mad dash through Elixir types

- integers and floats

  - `0x` prefixes literals using hexadecimal notation
  - `0o` prefixes literals using octal notation
  - `0b` prefixes literals using binary notation
  - `?ā` is the codepoint for the UTF character `ā`
  - `8/3`
  - `div(8, 3)`
  - `trunc(8/3)`
  - `round(8/3)`

- atoms

  - constants used to name things
  - `:"Elixir.Dictionary"`

- booleans

  - `true` and `false`
    - `and`, `or`, and `not` operators
  - `nil` and `false` are _falsy_; everything else is _truthy_
    - `&&`, `||`, and `!` operators

- ranges

  - a bounded set of integers
  - `4 in 8..3`
  - `for i <- 8..3, do: i*3`

- strings (and sigils)

  - sigils (…toads, and mysticism): a notation to create values from strings
  - strings are immutable
  - `"hello" === ~s{hello}`
  - `'hello' === ~c{hello}`
  - `~S"…"`

- regular expressions

  - the `=~` operator performs a regular expression match
  - ```ex
    "The quick brown cat jumps over the lazy caterpillar."
    |> String.replace(~r{cat}, "dog", global: false)
    ```

- tuples

  - _A fixed-lenght collection of values_
  - `{x, y}` and `{x, y, z}` used in geometry
  - They group things together.
  - These "things" can be any expression and they can resolve to different types.

- lists

  - A central part of Elixir
  - Lists are not arrays!

    - Arrays are data structures more suited to imperrative programming
      - one must explicitly iterate over them
      - prone to off-by-one errors
    - Lists are well suited to a functional, or declarative, style of programming
      - recursive data structures

  - Improper lists

- maps

  - _An unordered collection of key/value pairs._
  - A.k.a. dictionaries, hashes, associative arrays.
  - Oftentimes used as lookup tables.

## ✅ 05. Pattern Matching

- A major part of writting concise, idiomatic Elixir.
- _The ability to match arbitrary structured data against a pattern,_

  - _extracting elements of that data along the way._

- For a match to succeed, the LHS and the RHS must have the same shape, and each value on the RHS must match the corresponding value on the LHS. The LHS is the only one that can contain unbound variables.

  - the pattern must have the same shape as the RHS
  - any literals in the pattern must match corresponding values in the RHS
  - once bound, a variable in a pattern always represents that value

- 💛 **"Fail early"** is one of the keys to _highly reliable code_.

  - ```ex
    { :ok, file } = File.open("/etc/passwd")
    ```

- Ignoring values with `_`

- Pinning (`^`) values of variables to prevent rebinding

- Pattern matching and function calls

  - Multiple function heads
  - Pattern matching in parameter lists
    - transform
      - from functions that would otherwise be a mess of nested conditional logic
      - into a set of small, focused functions, each handling a single particualr flow
    - 💛 **major win**
      - makes code easier to write & easier to read
      - code that is easier to read is easier to change
      - that's what **good design** is.

- List and recursion
  - A list is either `[]` or `[h|t]`.

## 06. Let's Start Coding

## 07. Write a Text-based Client

## 08. Refactor the Dictionary

## 09. Process and Maintaining State

## 10. Use an Agent for the Dictionary

## 11. Applications: Making our Code Independent

## 12. No Mr. Dictionary, I Expect You to Die

## 13. The Story So Far…

## 14. Hangman: the OTP Server

## 15. Nodes and Distributed Elixir

## 16. From Server to Service: Make the Hangman Server Free-Standing

## 17. Distributed Text-Clients

## 18. Installing Phoenix

## 19. Hangman Using HTML Pages

## 20. Introduction to LiveView

## 21. Hangamn Using LiveView

## 22. It's a Wrap
