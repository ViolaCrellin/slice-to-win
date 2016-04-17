require 'legal_moves_calculator'
require 'computer_turn'

class Game

  attr_accessor :board
  attr_reader :legal_moves_klass, :turn_klass, :legal_moves

  def initialize(board, legal_moves_klass=LegalMovesCalculator, turn_klass=ComputerTurn)
    @board = board
    @legal_moves = :uncalculated
    @turn_klass = turn_klass
    @legal_moves_klass = legal_moves_klass
  end

  # def play
  #   odds_left.size.odd?
  # end

  def play
    return "0,#{board.size - 1}" if left_with_even?
    game_over? ?  declare_outcome : find_legal_moves
  end

  private

  def declare_outcome
    return "NO SOLUTION" if winner == :player2
    return turn_klass.find_first_turn.join(", ") if winner == :player1
  end

  def find_legal_moves
    @legal_moves = legal_moves_klass.new(board)
    right_sized_chunk_available? ? next_turn : declare_outcome
  end

  def next_turn
    current_turn = turn_klass.new(optimal_moves_available, board)
    turn_klass.add(current_turn.slice_choice)
    @board = current_turn.update_board
    play
  end

  def optimal_moves_available
    even_sized_chunk_needed? ? legal_moves.even_sized : legal_moves.odd_sized
  end

  def right_sized_chunk_available?
    even_sized_chunk_needed? ? legal_moves.even_sized.any? : legal_moves.odd_sized.any?
  end

  def even_sized_chunk_needed?
    board.size.odd? && odds_only.size != 1
  end

  def odds_left?
    odds_only.any?
  end

  def odds_only
    board.select {|x| x.odd?}
  end

  def game_over?
    board.size == 0 || odds_left? && board.size == 1
  end

  def left_with_even?
    board.inject(:+).even?
  end

  def winner
    turns_taken = turn_klass.turns.length
    turns_taken.odd? && game_over? ? :player1 : :player2
  end

end
