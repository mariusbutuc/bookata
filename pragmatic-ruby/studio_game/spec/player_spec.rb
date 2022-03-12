# frozen_string_literal: true

require_relative '../lib/player'

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
      expect(@player.to_s).to eq("I'm Larry with a health of 150 and a score of 155.")
    end

    it 'computes a score as the sum of its health and length of name' do
      expect(@player.score).to eq(@initial_health + @name.length)
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
      expect(@player.name_and_score).to eq('Larry............... 155')
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
