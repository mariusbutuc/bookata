# frozen_string_literal: true

require_relative('player')

players = [
  Player.new('moe'),
  Player.new('larry', 60),
  Player.new('curly', 125)
]

puts "\nThere are #{players.size} players in the game:"
# puts players
players.each do |player|
  puts "\t#{player}"
end

puts "\nHealth Commission Report"
players.each do |player|
  puts player.health
end

puts "\nRandom acts of …"
def random_action
  %i[blam w00t].sample
end
players.each do |player|
  3.times do |_|
    player.send(random_action)
  end

  puts player
end

players.pop
players.push(Player.new('shemp', 90))
puts "\nThere are #{players.size} players in the game:"
players.each do |player|
  puts "\t#{player}"
end
