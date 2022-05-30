# Notes

## ✅ 01. Welcome to Elixir for Programmers

## ✅ 02. Getting Started

## ✅ 03. Our First Project: The Dictionary

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

## ✅ 06. Let's Start Coding: The Hangman Game Logic

- Organization / Architecture / Design

  - Be strict about separating the API from the implementation.
  - Enforce a rule: Every function does just one thing; it is responsible for a single transformation
  - Good design: **cohesion** / **Single Responsibility Principle**
    - easier to change code
    - changes tend to be localized
    - a change is less likely to impact other areas of functionality

- The API; the way applications comunicate

  - APIs with state

    - state is an implementation detail
      - _easy_ to build UI from state, but also _inflexible_ (high coupling: UI to a particular implementation)
    - **opaque** to the users of the API
    - can change implementation without changing clients
    - state is represented by a token, similar to how a web app is using cookies

  - `Hangman.make_move/2` returns

    - `state'`: private » implementation-side value, representing the game
    - `tally`: public » client-side value, representing the current score, etc.

  - Tightening up the API
    - with type annotations
    - help the folks who use our code
    - give us feedback on possible errors

- Types, type annotations, and the tools that go with them

  - Dyalizer

    - Static type analyzer for Elixir & Erlang
    - works OK with regular code
    - works better with _annotated_ code

  - Adding _[typespecs]_ makes it easier for other people (future me included) to see what the _intent_ is

  - Creating types informs the designs

    - Similarly to how writing **tests** helps **clarify thinking**.
    - Working out the **types** of the functions gets me thinking about
      - **what** they do and
      - **how** they do it.
    - Help maintain APIs as tight as possible:
      - writing out types explicitly helps me see when I'm leaking implementation details out to the client.

- Code patterns

  - Logic lives in `lib/impl` rather than `lib/hangman`, as it allows for more semantically refined code spliting by concern
    - 💛 Remember to **separate** API from implementation
    - use `defdelegate` to make this separation easier
  - Module naming and using `alias`
  - [Structures][structs]
    - `defstruct …` can optionally give each field an initial value
    - Their structure cannot be changed at runtime, like maps can
    - Always associated with a module
      - Using `__MODULE__` makes changing the module name seamless
    - Purpose: hold the data processed by that module's functions (e.g., the internal game state)
    - Exporting a type `t` to describe the struct
    - `@opaque` types communicate that the internals of the type should remain private from anyone importing it.

- Dependencies

  - Local `path: …` dependencies
  - [Dependency documentation][deps]

- Using [guards] to further augment pattern matching

  - I also try to avoid **conditional logic** inside functions
    - Use multiple function heads with single purpose each, together with pattern matching and guards instead
    - I also noticed that this technique tends to improve the maintainability of the code
    - 👃 **code smell**: I find myself writting `if` or `cond`. Am I polluting the function with multiple responsibilities?

- The Single Responsibility Principle

  - Bob Martin states this as "it has just one reason to change."
  - Conditional statements are an indication that you're doing two things.
  - Fixing this will sometimes involve writing a new helper function. This is a _good thing_.

- Possible benefits of using `MapSet` instead of a `List`:

  - Me: more efficient lookups: `MapSet.member/2` over `Enum.member?/2` on lists.
  - Me: more idiomatic/intent-revealing `MapSet.equal?/2` instead of `Enum.sort(l1) == Enum.sort(l2)`
  - +Dave's: set-like use-case: unique entries + ability to test for membership.
  - +Dave's: Choosing the **highest level of abstraction** for the given use-case

- Ending a section with a failing test. It's intentional!
  - 👃 Getting to the end of a day?
  - 👃 Feeling tired and making mistakes?
  - 👃 About to take my Pomodoro 🍅 break?
  - This failing test tells me exactly where I am
  - A great way to recapture context

## ✅ 07. Write a Text-based Client

> To iterate is human, to recurse, divine.

- Write a simple text-based client that lets us play our game.

- To create code that loops while maintaining state we'll use recursion.

  - Tail Call Optimization (TCO) / Elimination — compile-time trick.
  - Rewriting functions into a tail-call recursive form. Sometimes worth it, sometimes not.

- Top-down approach:

  - Declare the desired public interface / "endpoints".
  - Add some comments/pseudocode.
  - Allow this exploration to inform the structure of the module, the structure of the state we need to keep, etc.
  - Use a `@type` to describe the state.
    - It's explocit enough.
    - If it's simple enough (a tuple), creating a structure for it might be overkill.
  - Incrementally build the implementation, step by step.
    - Using patten matching and multiple function heads.
    - We do not need all the functionality in place to be able to compile and test.
  - The game loop lives in the `interact/1` function.
    - Pseudocode can easily turn into Elixir code.
  - Expand (the game logic API module)[hangman/lib/hangman.ex] to expose the needed functionality.
  - Leverage the list of atoms from (Hangman's `state` type)[hangman/lib/type.ex].
    - Guide the incremental addition of functionality.
    - Ensure all the options are covered.

- [Homework](https://codestool.coding-gnome.com/courses/take/elixir-for-programmers-2/texts/29541835-finish-up-the-text-client)

  > (Difficult) If you'd like an interesting challenge, write another application where the computer plays the hangman game. For a simple implementation you could just blindly guess letters, starting at the most frequent.
  >
  > You could then optimize it by looking at the possible words. You'll need to add a new API function to the dictionary to return all the words of a given length. You can then use that list to decide which letter will give you the most information based on the current game state.

## ✅ 08. Refactor the Dictionary

## 09. Processes and Maintaining State

> Elixir's concurrency model is based on messages being passed between independent processes.

- In this context, a process is internal to the Elixir runtime system.

  - Different from the OS process.
  - Much more efficient.

### [`spawn`]: Create a new process

```ex
1..100_000
|> Enum.each(fn _ -> spawn(fn -> Process.sleep(5000) end) end)
```

- `spawn` runs a function in a separate process. It takes either an annonymous function or an MFA.

- When we ran 10 processes, our code looked like:

  ```ex
  1..10 |> Enum.each(fn idx -> spawn(Procs, :hello, ["#{idx} world!"]) end)
  ```

  Why did we need to wrap the `spawn` in a function?

- Elixir processes are _cheap_. You can create one in less than 10µS, and each takes less than 3k of memory (including their initial heap and stack).

### Messages: `send` and `receive`

```ex
iex()> h send
iex()> h receive

iex()> pid = spawn(Procs, :greeter, ["Salut"])
iex()> send(pid, "world!")
iex()> send(pid, "again")
iex()> Process.alive?(pid)
```

### Pattern matching messages

- Background process

  - Maintain state by passing it as a parameter in the recursive call.
  - Update state when handling the message.

- Messages: tuples with a verb and value(s).

- 💡 Maintain code **symmetry** (e.g., across function clauses.)

#### Homework:

- Can you think of a good argument to wrap all messages in tuples (e.g., `{ :reset }` or `{ :quit }`)?
- Can you think of a good reason not to (e.g., `:reset` or `:quit`)?

### Linking processes together

```ex
iex> h exit
iex> h spawn_link

iex> pid = spawn_link(Procs, :greeter, [0])
iex> send(pid, {:crash, :kaboom})
** (EXIT from #PID<0.160.0>) shell process exited with reason: :kaboom
iex> Process.alive?(pid)

iex> pid = spawn_link(Procs, :greeter, [0])
iex> send(pid, {:crash, :normal})
iex> Process.alive?(pid)

iex> pid = spawn_link(Procs, :greeter, [0])
iex> send(pid, {:crash, :shutdown})
** (EXIT from #PID<0.193.0>) shell process exited with reason: shutdown
iex> Process.alive?(pid)

iex> pid = spawn_link(Procs, :greeter, [0])
iex> send(pid, {:crash, {:shutdown, 42}})
** (EXIT from #PID<0.204.0>) shell process exited with reason: shutdown: 42
```

- `spawn` creates an isolated process.
- `spawn_linked` links the creating and created processes

  > If one dies an abnormal death, the other is killed

  - Avoids zombies

#### Seeking **high availability**?

> The trick is knowing how to crash, and when.

But first, let's have a look at `Agent`s…

#### Homework

- [ ] Spawn of the Dead

### Agents: An abstraction over state

Abstraction paralel: passing functions to `Enum.map/2`

| Data structure knowledge                                           | Domain/Business knowledge                                          |
| ------------------------------------------------------------------ | ------------------------------------------------------------------ |
| The fact that we have a `List`                                     | What we do to that `List`                                          |
| `Enum.map/2` knows how to ennumerate over the elements in a `List` | The function does what we need it to do to the individual elements |
| Have a generic background process: `Agent`                         | Pass in functions to manipulate its state                          |

```ex
iex> h Agent.start_link
iex> {:ok, counter} = Agent.start_link(fn -> 0 end)

iex> h Agent.get
iex> Agent.get(counter, fn state -> state end)

iex> h Agent.update
iex> Agent.update(counter, fn state -> state + 1 end)

iex> h Agent.get_and_update
iex> Agent.get_and_update(counter, fn state -> {state, state + 1} end)
```

- Benefits: Concurrence + fault tolerance. System performance.
- Beware: Writing OO language using Elixir syntax.

> 💡 The use of an agent is an _implementation_ detail. It should never leak into the rest of your code.

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

[`spawn`]: https://hexdocs.pm/elixir/Kernel.html#spawn/1
[deps]: https://hexdocs.pm/mix/Mix.Tasks.Deps.html
[guards]: https://hexdocs.pm/elixir/patterns-and-guards.html#guards
[structs]: https://elixir-lang.org/getting-started/structs.html
[typespecs]: https://hexdocs.pm/elixir/typespecs.html
