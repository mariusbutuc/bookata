defmodule IslandsEngine.Guesses do
  @moduledoc """
  Guesses are used to model the opponent’s board. It is a group of guessed
  coordinates separated into those that hit an island and those that missed.
  """

  alias __MODULE__

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  @doc """
  Convenience function that returns a Guesses struct with the group of
  coordinates separated into those that hit an island and those that missed.
  """
  def new(), do: %Guesses{hits: MapSet.new(), misses: MapSet.new()}
end
