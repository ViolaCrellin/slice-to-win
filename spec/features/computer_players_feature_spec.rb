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
      expect(one_number_game_fail.make_first_turn).to eq('NO SOLUTION')
    end
  end

  context 'starting board of [2]' do
    let(:one_number_even) {[2]}
    let(:one_number_game_win) {Game.new(one_number_even)}

    it 'returns \'0, 0\'' do
      expect(one_number_game_win.make_first_turn).to eq('0, 0')
    end
  end

  context 'starting board of [1, 2]' do
    let(:easy_array) {[1, 2]}
    let(:easy_game) {Game.new(easy_array)}

    it 'returns a slice position of \'1, 1\' ' do
      expect(easy_game.make_first_turn).to eq('1, 1')
    end
  end

  context 'starting board of [2, 2]' do
    #Failing because need to when to know when is a good idea to take all if all adds up to even
    let(:easy_array_evens) {[2, 2]}
    let(:easy_game_evens) {Game.new(easy_array_evens)}

    it 'returns a slice position of \'0, 1\' ' do
      expect(easy_game_evens.make_first_turn).to eq('0, 1')
    end
  end

  context 'starting board of [1, 2, 3]' do
    let(:easy_array_three) {[1, 2, 3]}
    let(:easy_game_take_all) {Game.new(easy_array_three)}

    it 'returns \'0, 2\'' do
      expect(easy_game_take_all.make_first_turn).to eq('0, 2')
    end
  end

  context 'starting board of [2, 5, 4]' do
    let(:easy_array_lose) {[2, 5, 4]}
    let(:easy_game_lose) {Game.new(easy_array_lose)}

    it 'returns \'NO SOLUTION\'' do
      expect(easy_game_lose.make_first_turn).to eq('NO SOLUTION')
    end
  end

  context 'starting board of [1, 2, 3, 5]' do
    let(:easy_array_fail_2) {[1, 2, 3, 5]}
    let(:easy_game_fail_2) {Game.new(easy_array_fail_2)}

    it 'returns \'0, 2\'' do
      expect(easy_game_fail_2.make_first_turn).to eq("0, 2")
    end
  end

  context 'starting board of [8, 4, 1, 7]' do
    let(:four_array_lose) {[8, 4, 1, 7]}
    let(:four_game) {Game.new(four_array_lose)}

    it 'returns \'NO SOLUTION\' ' do
      expect(four_game.make_first_turn).to eq("NO SOLUTION")
    end
  end

  context 'starting board of [8, 4, 1, 12]' do
    let(:four_array_win_two) {[8, 4, 1, 14]}
    let(:four_game_2) {Game.new(four_array_win_two)}

    it 'returns \'1, 1\' ' do
      expect(four_game_2.make_first_turn).to eq("1, 1")
    end
  end

  context 'starting board of [4, 5, 3, 7, 2]' do
    let(:easy_array_win) {[4, 5, 3, 7, 2]}
    let(:easy_game_win) {Game.new(easy_array_win)}

    it 'returns \'1, 2\'' do
      expect(easy_game_win.make_first_turn).to eq('1, 2')
    end
  end

  context 'starting board of [8, 4, 1, 7, 17, 20]' do
    let(:med_array) {[8, 4, 1, 7, 17, 20]}
    let(:med_game) {Game.new(med_array)}

    it 'returns \'1, 1\' ' do
      expect(med_game.make_first_turn).to eq('1, 1')
    end
  end
end
