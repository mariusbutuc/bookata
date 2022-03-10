# frozen_string_literal: true

require_relative '../../utils/die'

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

  # This method smells of :reek:TooManyStatements
  # rubocop:disable Metrics/MethodLength
  def play
    @players.each do |player|
      die = Die.new

      case die.roll
      when 1..2
        player.blam
      when 3..4
        puts("Skipping #{player.name}")
      else
        player.w00t
      end

      puts player
    end
  end
  # rubocop:enable Metrics/MethodLength

  def print_status
    puts self
    puts @players
    puts
  end

  def to_s
    "\nGame #{@title} loaded and ready with #{@players.size} players."
  end
end
