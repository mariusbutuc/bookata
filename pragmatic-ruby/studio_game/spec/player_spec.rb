# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/treasure_trove'

# rubocop:disable Metrics/BlockLength
describe Player do
  before do
    # Avoid w00t and blam feedback from interspercing with the spec results
    # by suppressing standard output
    $stdout = StringIO.new
  end

  context 'with generic parameters' do
    before do
      @name = 'larry'
      @initial_health = 150
      @player = Player.new(@name, @initial_health)
    end

    it 'has a capitalized name' do
      expect(@player.name).to eq('Larry')
    end

    it 'has an initial health' do
      expect(@player.health).to eq(@initial_health)
    end

    it 'has a string representation' do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.to_s).to eq("I'm Larry with health = 150, points = 100, hence score = 250.")
    end

    it 'computes a score as the sum of its health and points' do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.score).to eq(@initial_health + 100)
    end

    it 'increases health by 15 when w00ted' do
      @player.w00t

      expect(@player.health).to eq(@initial_health + 15)
    end

    it 'decreases health by 10 when blammed' do
      @player.blam

      expect(@player.health).to eq(@initial_health - 10)
    end

    it 'formats name and health' do
      expect(@player.name_and_health).to eq('Larry (150)')
    end

    it 'formats name and score' do
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.name_and_score).to eq('Larry............... 200')
    end

    it 'computes points as the sum of all found treasure points' do
      expect(@player.points).to eq(0)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(50)

      @player.found_treasure(Treasure.new(:crowbar, 400))

      expect(@player.points).to eq(450)

      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.points).to eq(500)
    end
  end

  context 'with a health greater than 100' do
    before do
      @player = Player.new('larry', 150)
    end

    it 'is strong' do
      expect(@player).to be_strong
    end
  end

  context 'with a health of no more than 100' do
    before do
      @player = Player.new('larry', 83)
    end

    it 'is (wimpy) not strong' do
      expect(@player).to_not be_strong
    end
  end

  context 'in a collection of players' do
    before do
      @player1 = Player.new('moe', 100)
      @player2 = Player.new('larry', 200)
      @player3 = Player.new('curly', 300)

      @players = [@player1, @player2, @player3]
    end

    it 'is sorted by decreasing score' do
      expect(@players.sort).to eq([@player3, @player2, @player1])
    end
  end
end
# rubocop:enable Metrics/BlockLength
