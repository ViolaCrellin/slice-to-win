require 'moves'

class LegalMovesCalculator

  attr_reader :current_board, :odd_sized, :even_sized, :move_klass

  def initialize(board, move_klass=Move)
    @current_board = board
    @move_klass = move_klass
    @even_sized = even_sized_chunks_available
    @odd_sized = odd_sized_chunks_available
  end

  private

  def even_sized_chunks_available
    make_moves.select {|move| move.chunk_size.even?}
  end

  def odd_sized_chunks_available
    make_moves.select {|move| move.chunk_size.odd?} + split_out_single_evens
  end
  #
  # def moves_available
  #   all_chunked_moves.select { |move| move.sum.even? }
  #   # + single_evens
  # end

  #
  # def moves_generator
  #   current_board.chunk { |int| int.even? }.map do |even, run|
  #     slice_position = [current_board.index(run.first), current_board.index(run.last)]
  #     move_klass.new(slice_position, run, even)
  #   end
  # end
  #
  # #
  #
  # def all_chunked_moves
  #   moves_generator.each do |move|
  #     move.split_move if move.need_splitting?
  #   end
  # end
  #
  def split_out_single_evens
    moves = []
    current_board.each_with_index do |int, index|
      if int.even?
        single_even_position = [index, index]
         moves << move_klass.new(single_even_position, [int])
      end
    end
    # print moves
    moves
  end

  def all_slices_you_could_make
    limit = current_board.size - 1
    [*0..limit].combination(2).to_a
  end

  def viable_slices
    possible_slices = all_slices_you_could_make.select {|slice| slice[0] < slice [1]}
    possible_slices.select {|slice| current_board[slice[0]..slice[1]].inject(:+).even?}
  end

  def make_moves
    viable_slices.map! do |slice|
      run = current_board[slice[0]..slice[1]]
      move_klass.new(slice, run)
    end
  end



# has to be a splittable even sized evens chunk
# has to be
#
# even board 4
# even number of chunks? 2
# means you need to take a single?
#
  #
  # def how_many_need_splitting
  #   moves_generator.select {|move| move.need_splitting?}
  #   # moves_available.size.even? && evens_in_chunks
  #   # the odds have to be taken together.
  #   # moves_generator.partition {|move| move.evens }
  # end
  #
  # def evens_in_chunks
  #   # moves_generator.partition {|move| move.evens }.first
  # end

end
