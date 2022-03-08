# frozen_string_literal: true

# Model the game player state and behaviour
class Player
  attr_accessor :name
  attr_reader :health

  def initialize(name, health = 100)
    @name = name.downcase
    @health = health
  end

  def motivate
    @health += 10
    puts "[#{name}] 👍"
  end

  def demotivate
    @health += 15
    puts "[#{name}] 👎"
  end

  def random
    send(%i[demotivate motivate].sample)
  end

  def to_s
    "[#{name}] #{health} HP."
  end
end

# Model the game coordination
class Game
  attr_reader :title

  def initialize(title)
    @title = title.capitalize
    @players = []
  end

  def add_player(player)
    @players.push(player)
  end

  def print_stats
    puts @players
  end

  def play
    puts self
    print_stats

    @players.each do |player|
      3.times { |_index| player.random }
    end

    print_stats
  end

  def to_s
    "\n#{@players.size} are ready to play #{title}!"
  end
end

kurukshetra = Game.new('kurukshetra')

[
  Player.new('Arjuna', 170),
  Player.new('Bishma'),
  Player.new('Krshna', 1000)
].each do |warrior|
  kurukshetra.add_player(warrior)
end

kurukshetra.play
