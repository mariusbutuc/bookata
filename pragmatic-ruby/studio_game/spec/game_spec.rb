# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

# rubocop:disable Metrics/BlockLength
describe Game do
  before do
    $stdout = StringIO.new
  end

  before do
    @game = Game.new('Knuckleheads')
    @rounds = 2

    @player = Player.new('moe')

    @game.add_player(@player)
  end

  context 'when a high number is rolled' do
    it 'w00ts the player' do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)

      @game.play(@rounds)

      expect(@player.health).to eq(100 + 15 * @rounds)
    end
  end

  context 'when a medium number is rolled' do
    it 'w00ts the player' do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)

      @game.play(@rounds)

      expect(@player.health).to eq(100)
    end
  end

  context 'when a low number is rolled' do
    it 'blams the player' do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)

      @game.play(@rounds)

      expect(@player.health).to eq(100 - 10 * @rounds)
    end
  end

  it "assigns a treasure for points during a player's turn" do
    expect(@player.points).to eq(0)

    @game.play(1)

    expect(@player.points).not_to eq(0)
  end

  it 'computes total points as the sum of all player points' do
    player2 = Player.new('larry')
    @game.add_player(player2)

    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))
    player2.found_treasure(Treasure.new(:crowbar, 400))

    expect(@game.total_points).to eq(500)
  end
end
# rubocop:enable Metrics/BlockLength
