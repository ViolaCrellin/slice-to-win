require 'game'
require 'legal_moves_calculator'
require 'computer_turn'

describe 'computer versus computer games of varing difficulty' do

  context 'starting board of [1, 2]' do
    let(:easy_array) {[1, 2]}
    let(:easy_game) {Game.new(easy_array)}

    it 'returns a slice position of \'1, 1\' ' do
      expect(easy_game.play).to eq('1, 1')
    end
  end

  context 'starting board of [1, 2, 3]' do
    let(:easy_array_fail) {[1, 2, 3]}
    let(:easy_game_fail) {Game.new(easy_array_fail)}

    it 'returns NO SOLUTION' do
      expect(easy_game_fail.play).to eq('NO SOLUTION')
    end
  end
end
