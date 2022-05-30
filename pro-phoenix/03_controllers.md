# Chapter 3. Controllers

## Working with Contexts

Building applications:

- break down complex ideas into discrete steps
- coalesce discrete functions into ideas
  - strategic layering and grouping of functions.

A context:

- group related functionality (domain entities)
- encapsulate patterns (data access / validation)
- APIs
  - expose critical logical concepts
  - hide complexity
  - hide implementation details.

Using contexts, system ~> _decouple_ and _isoalte_ ~> independent, manageable parts.

A context

- now
  - backed by hardcoded data
  - an _interface_
    - rapidly test the app as we build it
    - Test controllers, views, and templates with data-only structs.
- later
  - replace hardcoded implementation
  - with a full database-backed Ecto repository
  - the public interface remains unchanged.

## Building a Controller

1. Start from adding the **route** we want to handle: understand how a single route works first

- The `get` macro
- The `resources` macro:
  - `new`, `create`,
  - `index`, `show`,
  - `edit`, `update`
  - `delete`

2. Create the **controller**, using the `controller` API and containing an `index` action.

3. A **view** is a _module_ containing rendering functions.

- Modules responsible for rendering
- Convert data into a format that the user will consume (JSON / HTML).

4. A **template** is a _function_

- Web pages or fragments
  - Raw markup language ~ static markup
  - Embedded Elixir ~ native code
    - substitutions
    - loops
  - New HEEx engine (introduced in [1.6](https://phoenixframework.org/blog/phoenix-1.6-released))
    - defining attributes
    - defining function components
      > […] _stateless components_ implemented as _pure functions_ with the help of the `Phoenix.Component` module.

## Showing a User
