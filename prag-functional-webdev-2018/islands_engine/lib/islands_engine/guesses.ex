defmodule IslandsEngine.Guesses do
  @moduledoc """
  Guesses are used to model the opponent’s board. It is a group of guessed
  coordinates separated into those that hit an island and those that missed.
  """

  alias IslandsEngine.{Coordinate, Guesses}

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  @doc """
  Convenience function that returns a Guesses struct with the group of
  coordinates separated into those that hit an island and those that missed.
  """
  def new(), do: %Guesses{hits: MapSet.new(), misses: MapSet.new()}

  @doc """
  As players guess coordinates in the game, we’ll need to keep track of those
  guesses so that we can accurately represent their opponent’s board.
  """
  def add(%Guesses{} = guesses, :hit, %Coordinate{} = coordinate),
    do: update_in(guesses.hits, &MapSet.put(&1, coordinate))

  def add(%Guesses{} = guesses, :miss, %Coordinate{} = coordinate),
    do: update_in(guesses.misses, &MapSet.put(&1, coordinate))
end
