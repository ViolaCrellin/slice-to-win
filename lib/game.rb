require 'legal_moves_calculator'
require 'computer_turn'
require 'first_turn'


class Game

  attr_accessor :board
  attr_reader :legal_moves_klass, :turn_klass, :legal_moves, :first_turn

  def initialize(board, legal_moves_klass=LegalMovesCalculator, turn_klass=ComputerTurn, first_turn=FirstTurn)
    @first_turn = first_turn
    @board = board
    @legal_moves = :uncalculated
    @turn_klass = turn_klass
    @legal_moves_klass = legal_moves_klass
  end

  def make_first_turn
    # find_legal_moves
    initial_moves = legal_moves_klass.new(board)
    @first_turn = first_turn.new(initial_moves, board.dup)
    play
  end

  def play
    game_over? ?  declare_outcome : assess_moves
  end

  private

  def declare_outcome
    puts "\n INSIDE DECLARE OUTCOME AND THIS IS THE TURN HISTORY \n"
    puts turn_klass.turns
    winner == :player1 ? turn_klass.find_first_turn.slice_position.join(", ") : try_again
  end


  def find_legal_moves
    @legal_moves = legal_moves_klass.new(board)
  end

  def assess_moves
    find_legal_moves
    right_sized_chunk_available? ? next_turn : declare_outcome
  end

  def try_again
    first_turn.update_fails(turn_klass.find_first_turn.slice_position)
    @board = first_turn.original_board
    turn_klass.turns = {}
    return "NO SOLUTION" if first_turn.moves_available.empty?
    next_turn(first_turn.moves_available)
  end

  def next_turn(still_to_try=nil)
    moves_to_choose_from = (still_to_try ||= optimal_moves_available)
    # require 'pry'; binding.pry
    current_turn = turn_klass.new(moves_to_choose_from, board)
    turn_klass.add(current_turn.move_choice)
    set_up_next_turn(current_turn)
  end

  def set_up_next_turn(current_turn)
    @board = current_turn.update_board
    play
  end

  def right_sized_chunk_available?
    even_sized_chunk_needed? ? legal_moves.even_sized.any? : legal_moves.odd_sized.any?
  end

  def optimal_moves_available
    even_sized_chunk_needed? ? legal_moves.even_sized : legal_moves.odd_sized
  end

  def even_sized_chunk_needed?
    board.size.odd? && odds_only.size == 1
  end

  def odds_left?
    odds_only.any?
  end

  def odds_only
    board.select {|x| x.odd?}
  end

  def game_over?
    board.size == 0 || next_player_forced_odd?
  end

  def next_player_forced_odd?
    odds_left? && board.size == 1
  end

  def winner
    player1_wins? ? :player1 : :player2
  end

  def player1_wins?
    which_player_just_played == :player1 && (next_player_forced_odd? || game_over?)
  end

  def which_player_just_played
    turn_klass.turns.length.odd? ? :player1 : :player2
  end

  def first_turn?
    turn_klass.turns.any?
  end

end
