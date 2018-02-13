defmodule IslandsEngine.Coordinate do
  @moduledoc """
  Coordinates are ubiquitous in the game. They are basic units of both player's
  boards and of islands as well.

  Coordinates are identified by the combination of numbers for the row and the
  column.
  """

  alias __MODULE__

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @board_range 1..10

  @doc """
  We’ll be using coordinate structs a lot, so it would be convenient to have a
  function that took in the row and column and gave us back a coordinate struct.

  ## Examples

  As boards are 10×10, a coordinate needs to be on the board to be valid.

        iex> Coordinate.new(1, 1)
        {:ok, %IslandsEngine.Coordinate{col: 1, row: 1}}

        iex> Coordinate.new(-1, 1)
        {:error, :invalid_coordinate}

        iex> Coordinate.new(11, 1)
        {:error, :invalid_coordinate}
  """
  def new(row, col) when row in @board_range and col in @board_range,
    do: {:ok, %Coordinate{row: row, col: col}}

  def new(_row, _col), do: {:error, :invalid_coordinate}
end
