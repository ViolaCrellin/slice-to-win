class Move

attr_reader :chunk_size, :evens, :slice_position, :sum

  def initialize(slice_position, sliced_numbers, evens)
    @slice_position = slice_position
    @sliced_numbers = sliced_numbers
    @evens = evens
    @sum = sliced_numbers.inject(:+)
    @chunk_size = sliced_numbers.size
  end

  def need_splitting?
    sum.odd? && chunk_size > 1
  end

  def evenly_splittable?
    evens == true && chunk_size > 1
  end

  def split_move
    number_taken_out = @sliced_numbers.pop
    @sum -= number_taken_out
    @chunk_size -= 1
    @slice_position[-1] -= 1
  end

end
