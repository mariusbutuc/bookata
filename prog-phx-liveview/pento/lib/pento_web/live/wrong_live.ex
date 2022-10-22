defmodule PentoWeb.WrongLive do
  # NB: https://hexdocs.pm/phoenix_live_view/0.17.12/Phoenix.LiveView.html#module-example
  #     In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use PentoWeb, :live_view

  @doc """
  Establish the initial state for the live view by populating the _socket assigns_.
  """
  def mount(_params, _session, socket) do
    initial_state =
      socket
      |> assign(score: 0, message: "Make a guess:", time: time())

    {:ok, initial_state}
  end

  @doc """
  Render the HEEx template
  """
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      <br />
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    """
  end

  @doc """
  Handle the `guess`ing of a given `number`.
  """
  def handle_event("guess", %{"number" => guess} = _data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again."
    score = socket.assigns.score - 1

    new_state =
      socket
      |> assign(message: message, score: score, time: time())

    {:noreply, new_state}
  end

  defp time() do
    DateTime.utc_now() |> to_string()
  end
end
