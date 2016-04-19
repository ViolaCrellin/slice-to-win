class FirstTurn

  attr_accessor :moves_available, :attempts, :original_board
  # attr_reader :original_board

  def initialize(moves_available, board)
    @original_board = board
    @attempts = []
    @moves_available = moves_available.even_sized + moves_available.odd_sized
  end

  def update_fails(failed_move)
    attempts << failed_move
    moves_available.delete_if {|move| move.slice_position == failed_move}
  end

end
