require 'first_turn'

class ComputerTurn

  class << self; attr_accessor :turns

    def turns
      @turns ||= {}
    end

    def add(slice_made)
      turns[turns.size] = slice_made
    end

    def find_first_turn
      turns[0]
    end

  end

  attr_accessor :slice_choice, :board, :moves_available, :move_choice

  def initialize(moves_available, board)
    @moves_available = moves_available
    @board = board
    @move_choice = make_choice
    @slice_choice = move_choice.slice_position
  end

  def make_choice
    if first_turn?
      take_smallest_sum.first
    else
      take_biggest_chunk.last
    end
  end

  def update_board
    return slice_single if single_slice?
    return slice_chunk if !single_slice?
  end

  private

  def take_biggest_chunk
    moves_available.sort{|a, b| a.chunk_size <=> b.chunk_size}
  end

  def first_turn?
    ComputerTurn.find_first_turn == nil
  end

  def take_smallest_sum
    moves_available.sort{|a, b| a.sum <=> b.sum}
  end

  def slice_single
    board.delete_at(slice_choice.first)
    board
  end

  def slice_chunk
    board.slice!(slice_choice[0]..slice_choice[1])
    board
  end

  def single_slice?
    slice_choice[0] == slice_choice[1]
  end

end
