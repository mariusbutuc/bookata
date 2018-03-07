defmodule IslandsEngine.Island do
  @moduledoc """
  Islands come in five different shapes: :atoll, :dot, :l_shape, :s_shape, and
  :square. Players can position them on the board, and their opponents try to
  guess their position. Islands are made up of groups of coordinates.
  """

  alias IslandsEngine.{Coordinate, Island}

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  @doc "Return an island, given a valid type and a valid upper-left coordinate."
  def new(type, %Coordinate{} = upper_left) do
    with [_ | _] = offsets <- offsets(type),
         %MapSet{} = coordinates <- add_coordinates(offsets, upper_left) do
      {:ok, %Island{coordinates: coordinates, hit_coordinates: MapSet.new()}}
    else
      error -> error
    end
  end

  @doc """
  Check if an island is forrested, that is if the other player has planted a
  palm tree on every coordinate of the island.
  """
  def forested?(island),
    do: MapSet.equal?(island.coordinates, island.hit_coordinates)

  @doc """
  Guess if a coordinate is contained within the island.

  If the guess is a `:hit`, transform the island to add the coordinate to the
  hit coordinates set. If it is a `:miss`, communicate this.
  """
  def guess(island, coordinate) do
    case MapSet.member?(island.coordinates, coordinate) do
      true ->
        hit_coordinates = MapSet.put(island.hit_coordinates, coordinate)
        {:hit, %{island | hit_coordinates: hit_coordinates}}

      false ->
        :miss
    end
  end

  @doc "Check if two islands overlap."
  def overlaps?(existing_island, new_island) do
    not MapSet.disjoint?(existing_island.coordinates, new_island.coordinates)
  end

  @doc "Return the list of valid island types."
  def types, do: [:atoll, :dot, :l_shape, :s_shape, :square]

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

  defp add_coordinate(
         coordinates,
         %Coordinate{row: row, col: col},
         {row_offset, col_offset}
       ) do
    case Coordinate.new(row + row_offset, col + col_offset) do
      {:ok, coordinate} ->
        {:cont, MapSet.put(coordinates, coordinate)}

      {:error, :invalid_coordinate} ->
        {:halt, {:error, :invalid_coordinate}}
    end
  end
end
