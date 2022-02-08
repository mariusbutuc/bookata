defmodule Hangman.Impl.GameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new game returns correct word" do
    game = Game.new_game("wombat")

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ~w{w o m b a t}
  end

  test "each element of the `letters` list is a lower-case ASCII character" do
    game = Game.new_game("wombat")

    game.letters
    |> Enum.each(fn letter ->
      [codepoint | _] =
        letter
        |> String.to_charlist()

      assert codepoint in ?a..?z
    end)
  end

  test "state doesn't change if a game is won or lost" do
    for state <- [:won, :lost] do
      game =
        "wombat"
        |> Game.new_game()
        |> Map.put(:game_state, state)

      {new_game, _tally} = Game.make_move(game, "x")

      assert new_game == game
    end
  end

  test "validate that a guess is a single lowercase ASCII character" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "xyz")
    assert game.game_state == :bad_guess
  end

  test "a duplicate letter is reported" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "we record letters used" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "x")

    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end

  test "we recognize a letter in the word" do
    game = Game.new_game("wombat")

    {_game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess

    {_game, tally} = Game.make_move(game, "t")
    assert tally.game_state == :good_guess
  end

  test "we recognize a letter not in the word" do
    game = Game.new_game("wombat")

    {_game, tally} = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess

    {_game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess

    {_game, tally} = Game.make_move(game, "y")
    assert tally.game_state == :bad_guess
  end

  # hello
  test "can handle a sequence of moves" do
    [
      # To describe a move, why use a list instead of a map?
      # e.g., %{guess: "a", state: :bad_guess, turns: 6, letters: ["_", "_", "_", "_", "_"], used: ["a"]}
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["a", :already_used, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess, 6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["x", :bad_guess, 5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]]
    ]
    |> test_sequence_of_moves()
  end

  test "can handle a winning game" do
    [
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess, 6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["i", :bad_guess, 5, ["_", "e", "_", "_", "_"], ["a", "e", "i"]],
      ["o", :good_guess, 5, ["_", "e", "_", "_", "o"], ~w{a e i o}],
      ["l", :good_guess, 5, ["_", "e", "l", "l", "o"], ~w{a e i l o}],
      ["h", :won, 5, ["h", "e", "l", "l", "o"], ~w{a e h i l o}]
    ]
    |> test_sequence_of_moves()
  end

  test "can handle a losing game" do
    [
      ["a", :bad_guess, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["b", :bad_guess, 5, ["_", "_", "_", "_", "_"], ["a", "b"]],
      ["c", :bad_guess, 4, ["_", "_", "_", "_", "_"], ["a", "b", "c"]],
      ["d", :bad_guess, 3, ["_", "_", "_", "_", "_"], ~w{a b c d}],
      ["e", :good_guess, 3, ["_", "e", "_", "_", "_"], ~w{a b c d e}],
      ["f", :bad_guess, 2, ["_", "e", "_", "_", "_"], ~w{a b c d e f}],
      ["g", :bad_guess, 1, ["_", "e", "_", "_", "_"], ~w{a b c d e f g}],
      ["h", :good_guess, 1, ["h", "e", "_", "_", "_"], ~w{a b c d e f g h}],
      ["i", :lost, 0, ["h", "e", "_", "_", "_"], ~w{a b c d e f g h i}]
    ]
    |> test_sequence_of_moves()
  end

  defp test_sequence_of_moves(script) do
    game = Game.new_game("hello")

    script
    |> Enum.reduce(game, &check_one_move/2)
  end

  defp check_one_move([guess, state, turns, letters, used], game) do
    {new_game, tally} = Game.make_move(game, guess)

    assert tally.turns_left == turns
    assert tally.game_state == state
    assert tally.letters == letters
    assert tally.used == used

    new_game
  end
end
