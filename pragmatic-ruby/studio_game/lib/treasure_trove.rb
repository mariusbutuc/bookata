# frozen_string_literal: true

# Model the `Treasure` struct, with `name` and `points` attributes.
Treasure = Struct.new(:name, :points)

# The trove of available `Treasure` structs.
module TreasureTrove
  TREASURES = [
    Treasure.new(:pie, 5),
    Treasure.new(:bottle, 25),
    Treasure.new(:hammer, 50),
    Treasure.new(:skillet, 100),
    Treasure.new(:broomstick, 200),
    Treasure.new(:crowbar, 400)
  ].freeze

  def self.status
    TREASURES.reduce(["There are #{TREASURES.size} treasures to be found:"]) do |status, treasure|
      status.push("\tA #{treasure.name} is worth #{treasure.points} points")
    end
  end

  # Randomly "find" a treasure (say, every time a player takes a turn)
  def self.random
    TREASURES.sample
  end
end
