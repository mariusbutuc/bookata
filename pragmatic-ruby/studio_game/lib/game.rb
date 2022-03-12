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

  # This method smells of :reek:NestedIterators and :reek:TooManyStatements
  def play(rounds)
    puts self
    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  # This method smells of :reek:UncommunicativeVariableName
  # rubocop:disable Style/SymbolProc
  def print_stats
    strong_players, wimpy_players = @players.partition { |p| p.strong? }

    puts "\n#{title} Statistics:"

    puts "\n#{strong_players.size} strong players:"
    strong_players.each { |p| puts p.name_and_health }

    puts "\n#{wimpy_players.size} wimpy players:"
    wimpy_players.each { |p| puts p.name_and_health }

    puts "\n#{title} High Scores:"
    @players.sort.each { |p| puts p.name_and_score }
  end
  # rubocop:enable Style/SymbolProc

  def to_s
    "Game #{@title} loaded and ready with #{@players.size} players."
  end
end
