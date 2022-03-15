# frozen_string_literal: true

require_relative 'game_turn'
require_relative 'treasure_trove'

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

  # This method smells of :reek:NestedIterators
  def play(rounds)
    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        GameTurn.take_turn(player)
      end
    end
  end

  def prelude
    [to_s] << TreasureTrove.status
  end

  # This method smells of :reek:TooManyStatements
  def postlude
    stats = ["\n#{@title} Statistics:"]

    # rubocop:disable Style/SymbolProc
    strong_players, wimpy_players = @players.partition { |player| player.strong? }
    # rubocop:enable Style/SymbolProc
    stats << player_stats(strong_players, 'strong')
    stats << player_stats(wimpy_players, 'wimpy')
    stats << high_scores

    stats
  end

  def to_s
    "Game #{@title} loaded and ready with #{@players.size} players."
  end

  private

  # This method smells of :reek:UtilityFunction:
  def player_stats(players, player_characteristic)
    players.reduce(["\n#{players.size} #{player_characteristic} players:"]) do |stats, player|
      stats.push(player.name_and_health)
    end
  end

  def high_scores
    @players.sort.reduce(["\n#{@title} High Scores:"]) do |stats, player|
      stats.push(player.name_and_score)
    end
  end
end
