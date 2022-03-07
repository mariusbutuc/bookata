# frozen_string_literal: true

# rubocop:disable Style/Documentation
class Project
  attr_reader :name, :funding, :goal

  def initialize(name, funding, goal)
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

  def to_s
    "#{@name} has $#{@funding} in funding towards a goal of $#{@goal}."
  end
end
