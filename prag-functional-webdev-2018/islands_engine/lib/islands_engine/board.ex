defmodule IslandsEngine.Board do
  @moduledoc """
  The player's `Board` contains their `Island`s and it also brokers messages for
  them.

  The `Board` knows about and can address all the `Island`s. It can delegate
  functions down to them individually or as a group. This makes a `Board` both
  an orchestrator as well as an interface for actions that involve `Island`s.
  """

  alias IslandsEngine.{Coordinate, Island}

  @doc """
  Convenience function to keep `Board`s consistent with the rest of our domain
  entities.
  """
  def new(), do: %{}

  @doc """
  Allow players to (re-)position an `Island` of a certain type (`key`) on the
  `Board`.

  If the new position makes the new `Island` overlap an alreay existing one,
  communicate this. Overall, players can move their `Island`s around the `Board`
  until they declare them set.

  TODO: Marius is considering renaming the `key` argument to `island_type`:
        ```
        def position_island(board, island_type, %Island{} = island), do: #…
        ```

  TODO: Pros and Cons to the `Island` storing/knowing its type?
  """
  def position_island(board, key, %Island{} = island) do
    case overlaps_existing_island?(board, key, island) do
      true -> {:error, :overlapping_island}
      false -> Map.put(board, key, island)
    end
  end

  # Only check the islands that we aren't replacing.
  defp overlaps_existing_island?(board, new_key, new_island) do
    Enum.any?(board, fn {key, island} ->
      key != new_key and Island.overlaps?(island, new_island)
    end)
  end

  @doc """
  Check that the player has positioned an `Island` for all available types
  before declaring their `Island` set.
  """
  def all_islands_positioned?(board),
    do: Enum.all?(Island.types(), &Map.has_key?(board, &1))

  @doc """
  Check the `Board` to see if the given `Coordinate` matches any in an `Island`.

  Reply with four pieces of information
    - hit?                  whether the guess was a `:hit` or a `:miss`
    - forested?             the type of island that was forested, or `:none`
    - win?                  either `:win` or `:no_win` and finally
    - transformed board     the `Board` map itself
  """
  def guess(board, %Coordinate{} = coordinate) do
    board
    |> check_all_islands(coordinate)
    |> guess_response(board)
  end

  defp check_all_islands(board, coordinate) do
    Enum.find_value(board, :miss, fn {key, island} ->
      case Island.guess(island, coordinate) do
        {:hit, island} -> {key, island}
        :miss -> false
      end
    end)
  end

  defp guess_response({key, island}, board) do
    board = %{board | key => island}
    {:hit, forest_check(board, key), win_check(board), board}
  end

  defp guess_response(:miss, board), do: {:miss, :none, :no_win, board}

  defp forest_check(board, key) do
    case forested?(board, key) do
      true -> key
      false -> :none
    end
  end

  defp forested?(board, key) do
    board
    |> Map.fetch!(key)
    |> Island.forested?()
  end

  defp win_check(board) do
    case all_forested?(board) do
      true -> :win
      false -> :no_win
    end
  end

  defp all_forested?(board),
    do: Enum.all?(board, fn {_key, island} -> Island.forested?(island) end)
end
