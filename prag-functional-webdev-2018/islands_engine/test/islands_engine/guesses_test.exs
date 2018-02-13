defmodule IslandsEngine.GuessesTest do
  alias IslandsEngine.{Coordinate, Guesses}
  use ExUnit.Case

  doctest Guesses

  setup do
    guesses = Guesses.new()
    {:ok, coordinate1} = Coordinate.new(1, 1)
    {:ok, coordinate2} = Coordinate.new(2, 2)

    {:ok, guesses: guesses, coordinate1: coordinate1, coordinate2: coordinate2}
  end

  test "records multiple hits", %{guesses: g, coordinate1: c1, coordinate2: c2} do
    g = update_in(g.hits, &MapSet.put(&1, c1))
    g = update_in(g.hits, &MapSet.put(&1, c2))

    assert Enum.count(g.hits) == 2
  end

  test "records unique guesses", %{guesses: g, coordinate1: c1} do
    g = update_in(g.hits, &MapSet.put(&1, c1))
    g = update_in(g.hits, &MapSet.put(&1, c1))

    assert Enum.count(g.hits) == 1
  end
end
