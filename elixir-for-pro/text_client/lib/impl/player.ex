defmodule TextClient.Impl.Player do
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
      # Colour: #2a4
      apply(IO.ANSI, :color, rgb_255_to_5(34, 170, 68)),
      "   (turns left: ",
      # Colour: #1bb
      apply(IO.ANSI, :color, rgb_255_to_5(17, 187, 187)),
      tally.turns_left |> to_string(),
      # Colour: #2a4
      apply(IO.ANSI, :color, rgb_255_to_5(34, 170, 68)),
      ", used: ",
      # Colour: #bb1
      apply(IO.ANSI, :color, rgb_255_to_5(187, 187, 17)),
      tally.used |> Enum.join(", "),
      # Colour: #2a4
      apply(IO.ANSI, :color, rgb_255_to_5(34, 170, 68)),
      ")",
      IO.ANSI.reset()
    ]
  end

  defp get_guess() do
    "Next letter: "
    |> IO.gets()
    |> String.trim()
    |> String.downcase()
  end

  defp rgb_255_to_5(red, green, blue) do
    [
      base_255_to_5(red),
      base_255_to_5(green),
      base_255_to_5(blue)
    ]
  end

  defp base_255_to_5(base_255), do: round(base_255 * 5 / 255)
end
