# frozen_string_literal: true

# Rolls a random number between 1 and 6
class Die
  attr_reader :number

  def initialize
    roll
  end

  def roll
    @number = rand(1..6)
  end
end
