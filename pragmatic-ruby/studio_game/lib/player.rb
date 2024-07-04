# frozen_string_literal: true

# The game Player class, encapsulating a player's state (instance variables) and behaviour (instance methods).
class Player
  attr_reader :health, :name

  def initialize(name, health = 100)
    @name = name.capitalize
    @health = health
    @found_treasures = Hash.new(0)
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
    @health + points
  end

  def strong?
    @health >= 100
  end

  def <=>(other)
    other.score <=> score
  end

  def found_treasure(treasure)
    treasure_name = treasure.name
    treasure_points = treasure.points

    @found_treasures[treasure_name] += treasure_points

    puts "#{@name} found a #{treasure_name} worth #{treasure_points} points."
    puts "#{@name}'s treasures: #{@found_treasures}."
  end

  def points
    @found_treasures.values.reduce(0, :+)
  end

  def to_s
    "I'm #{@name} with health = #{@health}, points = #{points}, hence score = #{score}."
  end

  # TODO: Display concerns, to be mixed in

  def name_and_health
    "#{@name} (#{@health})"
  end

  def name_and_score
    formatted_name = @name.ljust(20, '.')
    "#{formatted_name} #{score}"
  end
end
