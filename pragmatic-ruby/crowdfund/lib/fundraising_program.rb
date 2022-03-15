# frozen_string_literal: true

require_relative 'funding_round'
require_relative 'pledge_pool'

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

  def brief
    status = [to_s]

    @projects.reduce(status) { |stats, project| stats << project }

    status.push(PledgePool.status)

    puts status
  end

  def simulate
    puts "\nLet the market simulation begin:"
    @projects.each do |project|
      FundingRound.raise(project)
    end
  end

  def debrief
    status = ["\nAt the end of the day, the portfolio looks like this:"]
    @projects.reduce(status) { |stats, project| stats << project }

    puts status
  end

  def to_s
    "\n#{title} contains #{@projects.size} projects looking to raise money."
  end
end
