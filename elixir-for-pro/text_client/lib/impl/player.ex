defmodule TextClient.Impl.Player do
  alias TextClient.Impl.Markup

  @typep game :: Hangman.game()
  @typep tally :: Hangman.tally()
  @typep state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    interact({game, tally})
  end

  @spec interact(state) :: :ok

  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts("Congratulations. You won!")
  end

  def interact({_game, _tally = %{game_state: :lost, letters: letters}}) do
    IO.puts(~s{Sorry, you lost. The word was "#{letters |> Enum.join()}".})
  end

  def interact({game, tally}) do
    tally
    |> feedback_for()
    |> IO.puts()

    tally
    |> current_word()
    |> IO.puts()

    Hangman.make_move(game, get_guess())
    |> interact()
  end

  defp feedback_for(_tally = %{game_state: :initializing, letters: letters}) do
    "Welcome! I'm thinking of a #{letters |> length()} letter word."
  end

  defp feedback_for(_tally = %{game_state: :good_guess}), do: "Good guess!"

  defp feedback_for(_tally = %{game_state: :bad_guess}),
    do: "Sorry, this letter is not in the word."

  defp feedback_for(_tally = %{game_state: :already_used}), do: "You already used this letter."

  defp current_word(tally) do
    [
      "Word so far: ",
      tally.letters |> Enum.join(" "),
      Markup.color("#2a4"),
      "   (turns left: ",
      Markup.color("#1bb"),
      tally.turns_left |> to_string(),
      Markup.color("#2a4"),
      ", used: ",
      Markup.color("#bb1"),
      tally.used |> Enum.join(", "),
      Markup.color("#2a4"),
      ")",
      Markup.reset()
    ]
  end

  defp get_guess() do
    "Next letter: "
    |> IO.gets()
    |> String.trim()
    |> String.downcase()
  end
end
