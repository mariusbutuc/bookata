defmodule IslandsEngine.Island do
  @moduledoc """
  Islands come in five different shapes: :atoll, :dot, :l_shape, :s_shape, and
  :square. Players can position them on the board, and their opponents try to
  guess their position. Islands are made up of groups of coordinates.
  """

  alias IslandsEngine.{Coordinate, Island}

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  @doc """
  Convenience function that returns an `Island` struct given a valid island type
  and a valid upper-left coordinate.

  ## Examples

      iex> {:ok, coordinate} = Coordinate.new(4, 6)
      iex> Island.new(:l_shape, coordinate)
      {:ok,
        %Island{
          coordinates: [
            %Coordinate{col: 6, row: 4},
            %Coordinate{col: 6, row: 5},
            %Coordinate{col: 6, row: 6},
            %Coordinate{col: 7, row: 6}
          ] |> Enum.into(MapSet.new()),
          hit_coordinates: MapSet.new()
        }}

      iex> {:ok, coordinate} = Coordinate.new(4, 6)
      iex(4)> Island.new(:wrong, coordinate)
      {:error, :invalid_island_type}

      iex(5)> {:ok, coordinate} = Coordinate.new(10, 10)
      iex(6)> Island.new(:l_shape, coordinate)
      {:error, :invalid_coordinate}

  """
  def new(type, %Coordinate{} = upper_left) do
    with [_ | _] = offsets <- offsets(type),
         %MapSet{} = coordinates <- add_coordinates(offsets, upper_left) do
      {:ok, %Island{coordinates: coordinates, hit_coordinates: MapSet.new()}}
    else
      error -> error
    end
  end

  defp offsets(:square), do: [{0, 0}, {0, 1}, {1, 1}, {1, 0}]
  defp offsets(:atoll), do: [{0, 0}, {0, 1}, {1, 1}, {2, 1}, {2, 0}]
  defp offsets(:dot), do: [{0, 0}]
  defp offsets(:l_shape), do: [{0, 0}, {1, 0}, {2, 0}, {2, 1}]
  defp offsets(:s_shape), do: [{0, 1}, {0, 2}, {1, 0}, {1, 1}]
  defp offsets(_), do: {:error, :invalid_island_type}

  defp add_coordinates(offsets, upper_left) do
    Enum.reduce_while(offsets, MapSet.new(), fn offset, acc ->
      add_coordinate(acc, upper_left, offset)
    end)
  end

  defp add_coordinate(coordinates, %Coordinate{row: row, col: col}, {row_offset, col_offset}) do
    case Coordinate.new(row + row_offset, col + col_offset) do
      {:ok, coordinate} ->
        {:cont, MapSet.put(coordinates, coordinate)}

      {:error, :invalid_coordinate} ->
        {:halt, {:error, :invalid_coordinate}}
    end
  end
end
