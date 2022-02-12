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
    IO.puts("Sorry, you lost. The word was #{letters |> Enum.join()}.")
  end

  def interact(_state = {_game, tally}) do
    # feedback
    tally
    |> feedback_for()
    |> IO.puts()

    # display current word
    # get next guess
    # make move
    # interact()
  end

  defp feedback_for(_tally = %{game_state: :initializing, letters: letters}) do
    "Welcome! I'm thinking of a #{letters |> length()} letter word."
  end

  defp feedback_for(_tally = %{game_state: :good_guess}), do: "Good guess!"

  defp feedback_for(_tally = %{game_state: :bad_guess}),
    do: "Sorry, this letter is not in the word."

  defp feedback_for(_tally = %{game_state: :already_used}), do: "You already used this letter."
end
