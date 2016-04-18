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

  attr_accessor :slice_choice, :board, :moves_available

  def initialize(moves_available, board)
    @moves_available = moves_available
    @board = board
    @slice_choice = make_choice
  end

  def make_choice
    # print moves_available
    # puts "******* moves available ^^^^^^^^"
    return first_turn_smallest if first_turn?
    take_biggest_chunk.slice_position
  end

  def update_board
    return slice_single if single_slice?
    return slice_chunk if !single_slice?
  end

  def take_biggest_chunk
    moves_available.sort{|a, b| a.chunk_size <=> b.chunk_size}.first
  end

  private

  def first_turn?
    ComputerTurn.find_first_turn == nil
  end

  def first_turn_smallest
    moves_available.sort{|a, b| a.sum <=> b.sum}.first.slice_position
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
