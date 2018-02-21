defmodule IslandsEngine.GuessesTest do
  alias IslandsEngine.{Coordinate, Guesses}
  use ExUnit.Case

  doctest Guesses

  setup do
    {:ok, guesses: Guesses.new()}
  end

  test "records multiple guesses", %{guesses: guesses} do
    {:ok, coordinate1} = Coordinate.new(1, 1)
    {:ok, coordinate2} = Coordinate.new(2, 2)

    guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))
    guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate2))

    assert Enum.count(guesses.hits) == 2
  end

  test "records duplicate guesses only once", %{guesses: guesses} do
    {:ok, coordinate1} = Coordinate.new(1, 1)

    guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))
    guesses = update_in(guesses.hits, &MapSet.put(&1, coordinate1))

    assert Enum.count(guesses.hits) == 1
  end

  describe "Guesses.add/3" do
    test "tracks hit coordinates in the hits set", %{guesses: guesses} do
      {:ok, coordinate} = Coordinate.new(8, 3)

      expected = %Guesses{hits: MapSet.new([coordinate]), misses: MapSet.new()}
      guessed = Guesses.add(guesses, :hit, coordinate)

      assert guessed == expected
    end

    test "tracks missed coordinates in the misses set", %{guesses: guesses} do
      {:ok, coordinate} = Coordinate.new(1, 2)

      expected = %Guesses{hits: MapSet.new(), misses: MapSet.new([coordinate])}
      guessed = Guesses.add(guesses, :miss, coordinate)

      assert guessed == expected
    end
  end
end
