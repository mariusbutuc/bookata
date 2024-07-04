# frozen_string_literal: true

# Model the `Pledge` struct, with `name` and `amount` attributes.
Pledge = Struct.new(:name, :amount)

# The pool of available `Pledge` structs.
module PledgePool
  PLEDGES = [
    Pledge.new('bronze', 50),
    Pledge.new('silver', 75),
    Pledge.new('gold', 100)
  ].freeze

  def self.status
    status_seed = ["There are #{PLEDGES.size} possible pledge amounts:"]

    PLEDGES.each_with_object(status_seed) do |pledge, status|
      status.push("\tA #{pledge.name} pledge is worth $#{pledge.amount}.")
    end
  end

  def self.random
    PLEDGES.sample
  end
end
