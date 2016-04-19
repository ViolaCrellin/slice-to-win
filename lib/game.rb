require 'legal_moves_calculator'
require 'computer_turn'

class Game

  attr_accessor :board
  attr_reader :legal_moves_klass, :turn_klass, :legal_moves, :original_board

  def initialize(board, legal_moves_klass=LegalMovesCalculator, turn_klass=ComputerTurn)
    @original_board = board
    @board = board
    @legal_moves = :uncalculated
    @turn_klass = turn_klass
    @legal_moves_klass = legal_moves_klass
  end

  def play
    game_over? ?  declare_outcome : find_legal_moves
  end


  private

  def declare_outcome
    puts "\n INSIDE DECLARE OUTCOME AND THIS IS THE TURN HISTORY \n"
    puts turn_klass.turns
    winner == :player1 ? turn_klass.find_first_turn.join(", ") : "NO SOLUTION"
  end

  # def try_again
  #   return "NO SOLUTION" if turn_klass.opening_turns.empty?
  #   @board = original_board
  #   failed_slice = turn_klass.find_first_turn
  #   # puts "\n INSIDE TRY AGAIN AND THIS SLICE FAILED \n"
  #   # print failed_slice
  #   @turn_klass.find_first_turn = {}
  #   @legal_moves = legal_moves_klass.new(board, failed_slice)
  #   next_turn
  # end



  def find_legal_moves
    @legal_moves = legal_moves_klass.new(board)
    turn_klass.save_first_turns(optimal_moves_available) if first_turn?
    right_sized_chunk_available? ? next_turn : declare_outcome
  end


  def next_turn
    current_turn = turn_klass.new(optimal_moves_available, board)
    turn_klass.add(current_turn.slice_choice)
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

  def evens_only
    board.select {|x| x.even?}
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
