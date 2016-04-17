require 'game'
require 'legal_moves_calculator'
require 'computer_turn'

describe 'computer versus computer games of varing difficulty' do

  before(:each) do
    ComputerTurn.instance_variable_set :@turns, nil
  end

  context 'starting board of [1]' do
    let(:one_number_odd) {[1]}
    let(:one_number_game_fail) {Game.new(one_number_odd)}

    it 'returns NO SOLUTION ' do
      expect(one_number_game_fail.play).to eq('NO SOLUTION')
    end
  end

  context 'starting board of [2]' do
    let(:one_number_even) {[2]}
    let(:one_number_game_win) {Game.new(one_number_even)}

    it 'returns \'0, 0\'' do
      expect(one_number_game_win.play).to eq('0,0')
    end
  end

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

  context 'starting board of [1, 2, 3, 5]' do
    let(:easy_array_fail_2) {[1, 2, 3, 5]}
    let(:easy_game_fail_2) {Game.new(easy_array_fail_2)}

    it 'returns NO SOLUTION' do
      expect(easy_game_fail_2.play).to eq('NO SOLUTION')
    end
  end

  context 'starting board of [4, 5, 3, 7, 2]' do
    let(:easy_array_win) {[4, 5, 3, 7, 2]}
    let(:easy_game_win) {Game.new(easy_array_win)}

    it 'returns \'1, 2\'' do
      expect(easy_game_win.play).to eq('1, 2')
    end
  end

  context 'starting board of [8, 4, 1, 7, 17, 20]' do
    let(:med_array) {[8, 4, 1, 7, 17, 20]}
    let(:med_game) {Game.new(med_array)}

    it 'returns \'1, 1\' ' do
      expect(med_game.play).to eq('1, 1')
    end
  end
end
