class Move

attr_reader :chunk_size, :slice_position, :sum, :sliced_numbers

  def initialize(slice_position, sliced_numbers, evens=true)
    @slice_position = slice_position
    @sliced_numbers = sliced_numbers
    @sum = sliced_numbers.inject(:+)
    @chunk_size = sliced_numbers.size
  end

end
