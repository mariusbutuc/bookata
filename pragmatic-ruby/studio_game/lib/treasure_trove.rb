# frozen_string_literal: true

# Model the `Treasure` struct, with `name` and `points` attributes.
Treasure = Struct.new(:name, :points)

# The collection of `Treasure` structs.
module TreasureTrove
  TREASURES = [
    Treasure.new(:pie, 5),
    Treasure.new(:bottle, 25),
    Treasure.new(:hammer, 50),
    Treasure.new(:skillet, 100),
    Treasure.new(:broomstick, 200),
    Treasure.new(:crowbar, 400)
  ].freeze
end
