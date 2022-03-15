# frozen_string_literal: true

require_relative '../lib/pledge_pool'

describe Pledge do
  before do
    @name = 'gold'
    @amount = 100
    @pledge = Pledge.new(@name, @amount)
  end
  it 'has a name' do
    expect(@pledge.name).to eq(@name)
  end

  it 'has an amount' do
    expect(@pledge.amount).to eq(@amount)
  end
end

# rubocop:disable Metrics/BlockLength
describe PledgePool do
  it 'has 3 pledges' do
    pledges = PledgePool::PLEDGES

    expect(pledges.size).to eq(3)
  end

  it 'has a bronze pledge worth $50' do
    pledge = PledgePool::PLEDGES[0]

    expect(pledge.name).to eq('bronze')
    expect(pledge.amount).to eq(50)
  end

  it 'has a silver pledge worth $75' do
    pledge = PledgePool::PLEDGES[1]

    expect(pledge.name).to eq('silver')
    expect(pledge.amount).to eq(75)
  end

  it 'has a gold pledge worth $100' do
    pledge = PledgePool::PLEDGES[2]

    expect(pledge.name).to eq('gold')
    expect(pledge.amount).to eq(100)
  end

  it 'returns a random pledge' do
    pledge = PledgePool.random

    expect(PledgePool::PLEDGES).to include(pledge)
  end

  it 'has a status' do
    expected_status = [
      'There are 3 possible pledge amounts:',
      "\tA bronze pledge is worth $50.",
      "\tA silver pledge is worth $75.",
      "\tA gold pledge is worth $100."
    ]

    expect(PledgePool.status).to eq(expected_status)
  end
end
# rubocop:enable Metrics/BlockLength
