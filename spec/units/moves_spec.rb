require './lib/moves.rb'

describe Move do
  let(:slice_position) {[1, 3]}
  let(:sliced_numbers_even) {[4, 8, 2]}
  let(:sliced_numbers_odd) {[5, 7, 3]}
  let(:evens) {true}
  let(:odds) {false}
  let(:move_odd) {described_class.new(slice_position, sliced_numbers_odd, odds)}
  let(:move_even) {described_class.new(slice_position, sliced_numbers_even, evens)}

  describe '#initialize' do

    it 'records the position of the move slice and the numbers' do
      expect(move_odd.slice_position).to eq(slice_position)
      expect(move_odd.sliced_numbers).to eq(sliced_numbers_odd)
      expect(move_odd.evens).to eq(odds)
    end

    it 'records the sum of the numbers and the size of the slice' do
      expect(move_odd.sum).to eq(5 + 7 + 3)
      expect(move_odd.chunk_size).to eq(3)
    end
  end

  describe '#need_splitting' do

    it 'returns true if the move has an odd sum' do
      expect(move_odd.need_splitting?).to be true
    end

    it 'returns false if the move has an even sum' do
      expect(move_even.need_splitting?).to be false
    end
  end

  describe '#split_move' do

    it 'takes out an odd number and updates the move' do
      move_odd.split_move
      expect(move_odd.sum.odd?).to eq(false)
      expect(move_odd.chunk_size).to eq(2)
      expect(move_odd.slice_position).to eq([1, 2])
    end

  end
end
