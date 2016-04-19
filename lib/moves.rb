class Move

attr_reader :chunk_size, :slice_position, :sum, :sliced_numbers

  def initialize(slice_position, sliced_numbers)
    @slice_position = slice_position
    @sliced_numbers = sliced_numbers
    @sum = sliced_numbers.inject(:+)
    @chunk_size = sliced_numbers.size
  end

  def splittable?
    chunk_size.even? || sliced_numbers.select {|int| int.even?}.any?
  end

end
