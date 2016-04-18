require './lib/computer_turn.rb'

describe ComputerTurn do
  let(:turn) {described_class}
  let(:a_slice) {[1, 1]}

  before(:each) do
    ComputerTurn.instance_variable_set :@turns, nil
  end

  context 'Class methods' do


    describe '.turns' do

      it 'stores @turns when .add is called' do
        expect{turn.add(a_slice)}.to change{turn.turns.size}.by(1)
      end
    end

    describe '.add' do

      before do
        turn.add(a_slice)
      end

      it '.adds a turn with its slice position and turn number to the @turns hash' do
        expect(turn.turns).to include ({0 => a_slice})
      end
    end

    describe '.find_first_turn' do

      before do
        turn.add(a_slice)
      end

      it 'will .find_first_turn made' do
        expect(turn.find_first_turn).to eq a_slice
      end
    end
  end

  context 'Instance Methods' do
    let(:board) {[1, 2]}
    let(:move) {double :move}
    let(:moves_available) {[move]}
    subject(:this_turn) {described_class.new(moves_available, board)}

    describe '#initialize' do

    before do
      allow(move).to receive(:slice_position).and_return([1, 1])
    end

      it 'calls make_choice with all the moves available' do
        expect_any_instance_of(turn).to receive(:make_choice)
        turn.new(moves_available, board)
      end

      it 'stores the board at the start of the turn so it can update it at the end' do
        expect(this_turn.board).to eq(board)
      end
    end
  end
end
