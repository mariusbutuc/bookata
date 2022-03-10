# frozen_string_literal: true

# Model a Project ready for crowdfunding
class Project
  attr_reader :name, :funding, :goal

  def initialize(name, goal, funding = 0)
    @name = "Project #{name.upcase}"
    @funding = funding
    @goal = goal
  end

  def name=(new_name)
    @name = "Project #{new_name.upcase}"
  end

  def outstanding
    @goal - @funding
  end

  def add_funds
    @funding += 25
    puts "#{@name} got more funds!"
  end

  def remove_funds
    @funding -= 15
    puts "#{@name} lost some funds!"
  end

  def fully_funded?
    @funding >= @goal
  end

  def to_s
    "#{@name} has $#{@funding} in funding towards a goal of $#{@goal}."
  end
end
