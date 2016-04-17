require 'legal_moves_calculator'

describe LegalMovesCalculator do
  let(:easy_board) {[1, 2]}
  let(:move_klass) {double(:move_klass, new: move)}
  let(:move) {double(:move, chunk_size: 1, sum: 2, need_splitting?: false)}
  let(:moves_calc_klass) {described_class}
  subject(:moves_calc) {described_class.new(easy_board, move_klass)}


  describe '#initialize' do

    before do
      allow(move_klass).to receive(:new).and_return(move)
      allow(move).to receive(:chunk_size).and_return(1)
      allow(move).to receive(:sum).and_return(2)
    end

    it 'has the current_board to find what legal moves are available' do
      expect(moves_calc.current_board).to eq(easy_board)
    end

    it 'has an uninstantiated Moves_klass from which to generate move objects' do
      expect(moves_calc.move_klass).to eq(move_klass)
    end

    it 'sets what even sized chunks are legal moves' do
      expect_any_instance_of(moves_calc_klass).to receive(:even_sized_chunks_available)
      moves_calc_klass.new(easy_board, move_klass)
    end

    it 'sets what odd sized chunks are legal moves' do
      expect_any_instance_of(moves_calc_klass).to receive(:even_sized_chunks_available)
      moves_calc_klass.new(easy_board, move_klass)
    end

    it 'puts even_sized legal moves into an array of move objects' do
      expect(moves_calc.odd_sized).to include(move)
      expect(moves_calc.even_sized).to be_empty
    end

  end

end
