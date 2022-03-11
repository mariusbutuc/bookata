# frozen_string_literal: true

require_relative '../../utils/die'

# A fundig round is responsible for rolling the die and updating the project
module FundingRound
  def self.raise(project)
    die = Die.new

    die.roll.even? ? project.add_funds : project.remove_funds
  end
end
