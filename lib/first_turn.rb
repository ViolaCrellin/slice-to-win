class FirstTurn

  attr_accessor :moves_available, :attempts, :original_board
  # attr_reader :original_board

  def initialize(moves_available, board)
    @original_board = board
    @attempts = {}
    @moves_available = moves_available
  end

  def update_fails(failed_move)
    @moves_available - [failed_move]
  end

end
