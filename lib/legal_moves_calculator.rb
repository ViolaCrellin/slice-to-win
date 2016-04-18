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
    moves_available.select {|move| move.chunk_size.even?}
  end

  def odd_sized_chunks_available
    moves_available.select {|move| move.chunk_size.odd?}
  end

  def moves_available
    all_chunked_moves.select { |move| move.sum.even? } + single_evens
  end


  def moves_generator
    current_board.chunk { |int| int.even? }.map do |even, run|
      slice_position = [current_board.index(run.first), current_board.index(run.last)]
      move_klass.new(slice_position, run, even)
    end
  end

  def all_chunked_moves
    moves_generator.each do |move|
      move.split_move if move.need_splitting?
    end
  end

  def single_evens
    moves = []
    current_board.each_with_index do |int, index|
      if int.even?
        single_even_position = [index, index]
         moves << move_klass.new(single_even_position, [int], true)
      end
    end
    moves
  end

  def chunked_chunks
    moves_available
  end

end
