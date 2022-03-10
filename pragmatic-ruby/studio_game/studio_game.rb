# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'

game = Game.new('Knuckleheads')

[
  Player.new('moe'),
  Player.new('larry', 60),
  Player.new('curly', 125)
].each do |player|
  game.add_player(player)
end

game.print_status
game.play
game.print_status
