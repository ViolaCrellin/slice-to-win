class ComputerTurn

  class << self; attr_accessor :turns, :opening_turns

    def turns
      @turns ||= {}
    end

    def opening_turns
      @opening_turns ||= []
    end

    def add(slice_made)
      turns[turns.size] = slice_made
    end

    def save_first_turns(legal_moves)
      opening_turns << legal_moves
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
    if take_all?
      take_all
    elsif first_turn?
      first_turn_logic
      # sort{|a, b| a.sum <=> b.sum }.first.slice_position

      # need to take out first turn logic so that you can record all possible first turns and see which to take
      # first_turn_smallest
    else
      take_biggest_chunk.last.slice_position
    end
  end

  def update_board
    return slice_single if single_slice?
    return slice_chunk if !single_slice?
  end

  def first_turn_logic
    # attempts = []
    # while moves_available.size < attempts.size
      # sort_by_smallest_sum.first.slice_position
      # (split it in half? might need to sort then also by chunk size)
      # right_sized_smallest_chunk = sort_by_smallest_sum.select do |move|
      #   (move.chunk_size.even? && board.size.odd?) || (move.chunk_size.odd? && board.size.even?)
      # end
      # return right_sized_smallest_chunk.first.slice_position if right_sized_smallest_chunk.any?
      # take_biggest_chunk.last.slice_position
    # else
      take_biggest_chunk.last.slice_position
    # end
  end



  private

  def take_all?
    left_with_even_sum? && moves_available.size.even?
  end

  def take_all_but_one
    moves_available.select{|move| move.chunk_size - 1 == board.size}
  end

  def killer_move?
    (board[0].odd? || board[-1].odd?)
  end

  def take_all
    [0, (board.size - 1)]
  end


  def take_biggest_chunk
    moves_available.sort{|a, b| a.chunk_size <=> b.chunk_size}
    # .last
  end

  def first_turn?
    ComputerTurn.find_first_turn == nil
  end

  def sort_by_smallest_sum
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

  def left_with_even_sum?
    board.inject(:+).even?
  end

end
