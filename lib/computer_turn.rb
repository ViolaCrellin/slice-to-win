class ComputerTurn

  class << self

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

  attr_accessor :slice_choice, :board

  def initialize(moves_available, board)
    @slice_choice = make_choice(moves_available)
    @board = board
  end

  def make_choice(moves_available)
    return first_turn_smallest(moves_available) if ComputerTurn.turns == {}
    moves_available.first.slice_position
  end

  def first_turn_smallest(moves_available)
    # puts "first turns available \n"
    # moves_available.partition {|move| move.splittable}
    # require 'pry'; binding.pry
    moves_available.sort{|a, b| a.sum <=> b.sum}.first.slice_position
  end

  def update_board
    return slice_single if single_slice?
    return slice_chunk if !single_slice?
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
