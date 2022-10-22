defmodule PentoWeb.WrongLive do
  # NB: https://hexdocs.pm/phoenix_live_view/0.17.12/Phoenix.LiveView.html#module-example
  #     In Phoenix v1.6+ apps, the line below should be: use MyAppWeb, :live_view
  use PentoWeb, :live_view

  @default_message "Make a guess:"

  @doc """
  Establish the initial state for the live view by populating the _socket assigns_.
  """
  def mount(_params, _session, socket) do
    {:ok, initial_state(socket)}
  end

  @doc """
  Render the HEEx template
  """
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- numbers() do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>

    <%= live_patch to: Routes.live_path(@socket, __MODULE__), replace: true do %>
      <button>Restart</button>
    <% end %>
    """
  end

  @doc """
  Handle the `guess`ing of a given `number`.
  """
  def handle_event("guess", %{"number" => guess} = _data, socket) do
    {guess, _remainder} = Integer.parse(guess)

    %{
      winner: winner,
      score: score
    } = socket.assigns

    {message, score} = validate(guess, winner, score)

    new_state =
      socket
      |> assign(message: message, score: score)

    {:noreply, new_state}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, initial_state(socket)}
  end

  defp numbers, do: 1..10

  defp pick_winner, do: numbers() |> Enum.random()

  defp initial_state(socket) do
    socket
    |> assign(score: 0, message: @default_message, winner: pick_winner())
  end

  defp validate(winner, winner, score) do
    message = "Your guess: #{winner}. Winner!"
    {message, score + 10}
  end

  defp validate(guess, _winner, score) do
    message = "Your guess: #{guess}. Wrong. Guess again."
    {message, score - 1}
  end
end
