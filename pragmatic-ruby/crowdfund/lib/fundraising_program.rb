# frozen_string_literal: true

require_relative 'funding_round'

# A fundraising program is a collection of projects (state) and interactions (behaviour) over them.
#
# Some projects might appeal more to the contributors and thus receive more funds,
# and some projects might fall behind schedule and have funds taken away.
class FundraisingProgram
  attr_reader :title

  def initialize(title)
    @title = title.capitalize
    @projects = []
  end

  def add_project(project)
    @projects.push(project)
  end

  def showcase
    puts self
    @projects.each { |project| puts "\t#{project}" }
    puts
  end

  # This method smells of :reek:FeatureEnvy
  def simulate
    @projects.each do |project|
      FundingRound.raise(project)
    end
  end

  def to_s
    "\n#{title} contains #{@projects.size} projects looking to raise money."
  end
end
