# Programming Phoenix LiveView [↗️]

## Plan

0. [x] Introduction

### Part 1. Code Generation

1.  [x] Get to Know LiveView

    1.  The "`live` route": it receives/handles the request

        ```ex
        live "/guess", WrongLive
        ```

    1.  The ~~Controller~~ LiveView: `PentoWeb.WrongLive`

        - the `mount/3` function: it sets up the initial state by populating the _socket assigns_.
        - the `render/1` function: it renders the HEEx template, marked by [the `~H` sigil](https://hexdocs.pm/phoenix_live_view/0.17.0/Phoenix.LiveView.Helpers.html#sigil_H/2) (e.g., `@score` » `socket.assigns.score`). Pure & Functional.

    1.  The `LiveView` loop: it provides the interactivity

        - First open a persistent connection between the client and the server using WebSockets.
        - Then call `mount/3` and `render/1` _again_, stating _the LiveView loop_.
          1.  receive events
          1.  change state (implement our own event handlers)
          1.  render the page again

    1.  Determining which data values have changed and need to be re-rendered

        - `LiveView` keeps track of the data in socket assigns.
          - any changes to that data will instruct LiveView to send a diff down to the client

1.  [ ] Phoenix & Authentication
1.  [ ] Generators: Contexts & Schemas
1.  [ ] Generators: Live Views & Templates

### Part 2. LiveView Composition

5.  [ ] Forms & Changesets
6.  [ ] Function Components
7.  [ ] Live components

### Part 3. Exctend LiveView

8.  [ ] Build an Interactive Dashboard
9.  [ ] Build a Distributed Dashboard
10. [ ] Test you Live Views

### Part 4. Graphics & Custom Code Organization

11. [ ] Build the Game Core
12. [ ] Render Graphics with SVG
13. [ ] Establish Boundaries & APIs

    [↗️]: https://pragprog.com/titles/liveview/programming-phoenix-liveview/
