# frozen_string_literal: true

# A collection of Players and some behaviour that lets us play the Game.
class Game
  attr_reader :title

  def initialize(title)
    @title = title.capitalize
    @players = []
  end

  def add_player(player)
    @players.push(player)
  end

  # This method smells of :reek:NestedIterators
  def play
    @players.each do |player|
      3.times { |_| player.random_interaction }
      puts player
    end
  end

  def print_status
    puts self
    puts @players
    puts
  end

  def to_s
    "\nGame #{@title} loaded and ready with #{@players.size} players."
  end
end
