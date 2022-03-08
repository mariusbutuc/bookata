# frozen_string_literal: true

require_relative('game')
require_relative('player')

knuckleheads = Game.new('Knuckleheads')

[
  Player.new('moe'),
  Player.new('larry', 60),
  Player.new('curly', 125)
].each do |player|
  knuckleheads.add_player(player)
end

knuckleheads.print_status
knuckleheads.play
knuckleheads.print_status
