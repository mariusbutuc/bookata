# frozen_string_literal: true

# The game Player class, encapsulating a player's state (instance variables) and behaviour (instance methods).
class Player
  attr_reader :health, :name

  def initialize(name, health = 100)
    @name = name.capitalize
    @health = health
  end

  # "Custom" attr_writter :name
  def name=(new_name)
    @name = new_name.capitalize
  end

  def blam
    @health -= 10
    puts "#{@name} got blammed!"
  end

  def w00t
    @health += 15
    puts "#{@name} got w00ted!"
  end

  def score
    @health + @name.length
  end

  def strong?
    @health >= 100
  end

  def <=>(other)
    other.score <=> score
  end

  def name_and_health
    "#{name} (#{health})"
  end

  def name_and_score
    formatted_name = name.ljust(20, '.')
    "#{formatted_name} #{score}"
  end

  def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}."
  end
end

if __FILE__ == $PROGRAM_NAME
  player = Player.new('moe')
  puts player.name
  puts player.health

  player.w00t
  puts player.health

  player.blam
  puts player.health
end