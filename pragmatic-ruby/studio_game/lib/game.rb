# frozen_string_literal: true

require_relative 'game_turn'

# A collection of Players and the behaviour that lets us play the Game
class Game
  attr_reader :title

  def initialize(title)
    @title = title.capitalize
    @players = []
  end

  def add_player(player)
    @players.push(player)
  end

  # This method smells of :reek:DuplicateMethodCall
  def play
    puts self

    @players.each do |player|
      puts player
      GameTurn.take_turn(player)
      puts player
    end
  end

  def to_s
    "Game #{@title} loaded and ready with #{@players.size} players."
  end
end
