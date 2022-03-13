# frozen_string_literal: true

require_relative '../lib/treasure_trove'

describe Treasure do
  before do
    @name = :laptop
    @points = 5_000
    @treasure = Treasure.new(@name, @points)
  end
  it 'has a name attribute' do
    expect(@treasure.name).to eq(@name)
  end

  it 'has a points attribute' do
    expect(@treasure.points).to eq(@points)
  end
end

# rubocop:disable Metrics/BlockLength
describe TreasureTrove do
  it 'has six treasures' do
    treasures = TreasureTrove::TREASURES

    expect(treasures.size).to eq(6)
  end

  it 'has a pie worth 5 points' do
    pie = TreasureTrove::TREASURES[0]

    expect(pie).to eq(Treasure.new(:pie, 5))
  end

  it 'has a bottle worth 25 points' do
    bottle = TreasureTrove::TREASURES[1]

    expect(bottle).to eq(Treasure.new(:bottle, 25))
  end

  it 'has a hammer worth 50 points' do
    hammer = TreasureTrove::TREASURES[2]

    expect(hammer).to eq(Treasure.new(:hammer, 50))
  end

  it 'has a skillet worth 100 points' do
    skillet = TreasureTrove::TREASURES[3]

    expect(skillet).to eq(Treasure.new(:skillet, 100))
  end

  it 'has a broomstick worth 200 points' do
    broomstick = TreasureTrove::TREASURES[4]

    expect(broomstick).to eq(Treasure.new(:broomstick, 200))
  end

  it 'has a crowbar worth 400 points' do
    crowbar = TreasureTrove::TREASURES[5]

    expect(crowbar).to eq(Treasure.new(:crowbar, 400))
  end
end
# rubocop:enable Metrics/BlockLength
