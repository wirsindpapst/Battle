require 'player'
require 'game'


describe Game do
  subject(:game)  { described_class.new(snuggles, amaal) }
  let(:snuggles) { double(:player) }
  let(:amaal)     { double(:player)  }

  describe 'initialize' do
    it 'starts with with player 1' do
      expect(game.current_player).to eq snuggles
    end
  end

  describe '#switch_turn' do
    it 'changes the current player' do
      game.switch_turn
      expect(game.current_player).to eq amaal
    end
  end

  describe '#player_1' do
    it 'retrieves the first player' do
      expect(game.player_1).to eq snuggles
    end
  end

  describe '#player_2' do
    it 'retrieves the second player' do
      expect(game.player_2).to eq amaal
    end
  end

  describe '#attack' do
    it 'damages the player' do
      amaal = Player.new('Amaal')
      allow(snuggles).to receive(:poisoned)
      expect(amaal).to receive(:receive_damage)
      game.attack(amaal)
    end
  end

  describe '#paralyse' do
    it 'the opponents loses ther turn if successful' do
      allow(snuggles).to receive(:poisoned)
      allow(game).to receive(:random_chance).and_return(true)
      game.paralyse(amaal)
      expect(game.current_player).to eq snuggles
    end
  end

  context 'player HP reaches zero' do
    it 'ends the game' do
      test_player = Player.new('Amaal')
      current_game = Game.new(test_player, snuggles)
      allow(snuggles).to receive(:random_damage).and_return(10)
      6.times {current_game.attack(test_player)}
      expect(current_game.end_game?).to eq(true)
    end
  end

end
