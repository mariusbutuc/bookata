defmodule IslandsEngine.IslandTest do
  alias IslandsEngine.{Coordinate, Island}

  use ExUnit.Case

  describe "Island.new/2" do
    test "builds an island for a valid type starting from a valid coordinate" do
      {:ok, coordinate} = Coordinate.new(4, 6)

      expected_island = %Island{
        coordinates:
          MapSet.new([
            %Coordinate{col: 6, row: 4},
            %Coordinate{col: 6, row: 5},
            %Coordinate{col: 6, row: 6},
            %Coordinate{col: 7, row: 6}
          ]),
        hit_coordinates: MapSet.new()
      }

      {:ok, actual_island} = Island.new(:l_shape, coordinate)

      assert actual_island == expected_island
    end

    test "reports when the island type is invalid" do
      {:ok, coordinate} = Coordinate.new(4, 6)

      assert Island.new(:wrong, coordinate) == {:error, :invalid_island_type}
    end

    test "reports when the starting coordinate is invalid" do
      {:ok, coordinate} = Coordinate.new(10, 10)

      assert Island.new(:l_shape, coordinate) == {:error, :invalid_coordinate}
    end
  end

  describe "Island.overlaps?/2" do
    test "detects when islands overlap" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)

      {:ok, dot_coordinate} = Coordinate.new(1, 2)
      {:ok, dot} = Island.new(:dot, dot_coordinate)

      assert Island.overlaps?(square, dot)
    end

    test "detects when islands do not overlap" do
      {:ok, square_coordinate} = Coordinate.new(1, 1)
      {:ok, square} = Island.new(:square, square_coordinate)

      {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
      {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)

      refute Island.overlaps?(square, l_shape)
    end
  end

  describe "Island.guess/2" do
    test "communicates a :miss" do
      {:ok, dot_coordinate} = Coordinate.new(4, 4)
      {:ok, island} = Island.new(:dot, dot_coordinate)
      {:ok, miss_coordinate} = Coordinate.new(2, 2)

      assert :miss == Island.guess(island, miss_coordinate)
    end

    test "when :hit, adds the coordinate to the hit coordinates set" do
      {:ok, dot_coordinate} = Coordinate.new(4, 4)
      {:ok, island} = Island.new(:dot, dot_coordinate)
      {:ok, hit_coordinate} = Coordinate.new(4, 4)

      {:hit, island} = Island.guess(island, hit_coordinate)

      assert MapSet.member?(island.hit_coordinates, hit_coordinate)
    end
  end

  describe "Island.forested?/1" do
    test "checks if all coordinates are hit" do
      {:ok, coordinate} = Coordinate.new(4, 4)
      {:ok, island} = Island.new(:dot, coordinate)

      {:hit, island} = Island.guess(island, coordinate)

      assert Island.forested?(island)
    end
  end
end
