require './lib/moves.rb'

describe Move do
  let(:slice_position) {[1, 3]}
  let(:sliced_numbers_one) {[4, 8, 2]}
  let(:move) {described_class.new(slice_position, sliced_numbers_one)}

  describe '#initialize' do

    it 'records the position of the move slice and the numbers' do
      expect(move.slice_position).to eq(slice_position)
      expect(move.sliced_numbers).to eq(sliced_numbers_one)
    end

    it 'calculates the sum of the numbers and the size of the slice' do
      expect(move.sum).to eq(4 + 8 + 2)
      expect(move.chunk_size).to eq(3)
    end
  end
end
