# frozen_string_literal: true

require_relative '../../utils/die'
require_relative 'treasure_trove'

# A game turn involves rolling the die and updating the player
module GameTurn
  def self.take_turn(player)
    die = Die.new

    case die.roll
    when 1..2
      player.blam
    when 3..4
      puts("Skipping #{player.name}")
    else
      player.w00t
    end

    find_treasure(player)
  end

  # "private" 😊

  def self.find_treasure(player)
    player.found_treasure(TreasureTrove.random)
  end
end
