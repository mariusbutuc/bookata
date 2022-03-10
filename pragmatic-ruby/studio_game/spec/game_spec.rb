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

    @initial_health = 100
    @player = Player.new('moe', @initial_health)

    @game.add_player(@player)
  end

  context 'when a high number is rolled' do
    it 'w00ts the player' do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)

      @game.play

      expect(@player.health).to eq(@initial_health + 15)
    end
  end

  context 'when a medium number is rolled' do
    it 'w00ts the player' do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)

      @game.play

      expect(@player.health).to eq(@initial_health)
    end
  end

  context 'when a low number is rolled' do
    it 'blams the player' do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)

      @game.play

      expect(@player.health).to eq(@initial_health - 10)
    end
  end
end
# rubocop:enable Metrics/BlockLength
