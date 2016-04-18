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

  def split_out_single_evens
    moves = []
    current_board.each_with_index do |int, index|
      if int.even?
        single_even_position = [index, index]
         moves << move_klass.new(single_even_position, [int])
      end
    end
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

end
