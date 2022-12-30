# LiveView in Action: Button Clicks

1. Router

   - [`Phoenix.LiveView.Router.live/4` route][live/4]: path, live module

2. Live module

   - Not a Phoenix controller, rather a long-running live view process.

   * [`Phoenix.LiveView.mount/3` callback][mount/3]

     - automatically called when the request comes through the router
     - arguments
       - `params`: map containing query parameters + router path parameters
       - `session`: the connection session
       - `socket`: the LiveView socket struct
     - initialize the **state** of the live view process by [`Phoenix.Component.assign/3`][assign/3]-ing values to the `socket`

   * [`Phoenix.LiveView.render/1` callback][render/1]

     - render a template
     - colocate short templates using [`Phoenix.Component.sigil_H/2`][sigil_h/2]
       - what in a `LEEx` template is: `<span style="width: <%= @brightness%>%">`
       - in a `HEEx` template becomes: `<span style={"width: #{@brightness}%"}>`
     - include values assigned to the socket

     - LiveView [bindings]

   * [`Phoenix.LiveView.handle_event/3` callback][handle_event/3]

     - one for each inbound event
     - arguments

       - event name
       - event payload
       - socket

     - [`Phoenix.Component.update/3`][update/3]

[assign/3]: https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#assign/3
[bindings]: https://hexdocs.pm/phoenix_live_view/bindings.html
[handle_event/3]: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#c:handle_event/3
[live/4]: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Router.html#live/4
[mount/3]: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#c:mount/3
[render/1]: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#c:render/1
[sigil_h/2]: https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#sigil_H/2
[update/3]: https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#update/3
