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
    @first_turn = first_turn.new(all_moves_available, board)
    
  end


  def play
    game_over? ?  declare_outcome : find_legal_moves
  end

  private

  def declare_outcome
    puts "\n INSIDE DECLARE OUTCOME AND THIS IS THE TURN HISTORY \n"
    puts turn_klass.turns
    winner == :player1 ? turn_klass.find_first_turn.slice_position.join(", ") : try_again
  end

  def find_legal_moves
    @legal_moves = legal_moves_klass.new(board)
    right_sized_chunk_available? ? next_turn : declare_outcome
  end

  def all_moves_available
    legal_moves.even_sized + legal_moves.odd_sized
  end

  def try_again
    turn_klass.turns = {}
    @board = first_turn.original_board
    require 'pry'; binding.pry
    first_turn.update_fails(turn_klass.find_first_turn)
    return "NO SOLUTION" if first_turn.moves_available.empty?
    next_turn
  end

  def next_turn
    current_turn = turn_klass.new(optimal_moves_available, board)
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
    turns_taken = turn_klass.turns.length
    turns_taken.odd? ? :player1 : :player2
  end

  def first_turn?
    turn_klass.turns.any?
  end

end
