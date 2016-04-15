class Move

attr_reader :chunk_size, :evens, :slice_position, :sum, :splittable

  def initialize(slice_position, sliced_numbers, evens)
    @slice_position = slice_position
    @evens = evens
    @sum = sliced_numbers.inject(:+)
    @chunk_size = sliced_numbers.size
    @splittable = evens == true && chunk_size > 1
  end

end
