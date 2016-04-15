require 'moves'

class LegalMovesCalculator

  attr_reader :current_board, :odd_sized, :even_sized, :move_klass


  def initialize(board, move_klass=Move)
    @current_board = board
    @move_klass = move_klass
    @even_sized = even_sized_chunks_available
    @odd_sized = odd_sized_chunks_available
  end

  def even_sized_chunks_available
    moves_available.select {|move| move.chunk_size.even?}
  end

  def odd_sized_chunks_available
    moves_available.select {|move| move.chunk_size.odd?}
  end

  def moves_available
    moves_generator.select { |move| move.sum.even? }
  end

  def moves_generator
    current_board.chunk { |int| int.even? }.map do |even, run|
      slice_position = [current_board.index(run.first), current_board.index(run.last)]
      move_klass.new(slice_position, run, even)
    end
  end

end
