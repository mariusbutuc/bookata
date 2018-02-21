defmodule IslandsEngine.BoardTest do
  alias IslandsEngine.{Board, Coordinate, Island}

  use ExUnit.Case

  setup_all do
    board = Board.new()
    {:ok, square_coordinate} = Coordinate.new(1, 1)
    {:ok, square} = Island.new(:square, square_coordinate)
    board = Board.position_island(board, :square, square)

    {:ok, board: board}
  end

  describe "Board.position_island/3" do
    test "positions a non-overlapping island", %{board: board} do
      {:ok, dot_coordinate} = Coordinate.new(3, 3)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      transformed_board = Board.position_island(board, :dot, dot)

      assert match?(%{dot: %Island{}, square: _}, transformed_board)
    end

    test "returns an error for an overlapping island", %{board: board} do
      overlapping_coordinate =
        board.square.coordinates
        |> MapSet.to_list()
        |> List.last()

      {:ok, dot} = Island.new(:dot, overlapping_coordinate)

      assert {:error, :overlapping_island} == Board.position_island(board, :dot, dot)
    end
  end

  describe "Board.guess/2" do
    test "comminucates a miss", %{board: board} do
      {:ok, guess_coordinate} = Coordinate.new(10, 10)

      missed_guess = Board.guess(board, guess_coordinate)

      assert {:miss, :none, :no_win, board} == missed_guess
    end

    test "guess that doesn't forest an island or win", %{board: board} do
      {:ok, hit_coordinate} = Coordinate.new(1, 1)

      hit_guess = Board.guess(board, hit_coordinate)

      assert match?({:hit, :none, :no_win, _transformed_board}, hit_guess)
    end

    test "guess for a win", %{board: board} do
      [win_coordinate | almost_win_coordinatees] = MapSet.to_list(board.square.coordinates)
      hit_coordinates = Enum.into(almost_win_coordinatees, MapSet.new())
      square = %{board.square | hit_coordinates: hit_coordinates}
      board = Board.position_island(board, :square, square)

      win_guess = Board.guess(board, win_coordinate)

      assert match?({:hit, :square, :win, _transformed_board}, win_guess)
    end
  end
end
