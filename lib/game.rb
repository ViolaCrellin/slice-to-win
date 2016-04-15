# responsible for initializing the game with the board.
# responsible for calling new situation_assessment
# will assign players to the classes they have access to.
# ComputerPlayer will be able to access legal moves calculator
require 'legal_moves_calculator'
require 'computer_turn'

class Game

  attr_accessor :board, :legal_moves, :current_turn
  attr_reader :legal_moves_klass, :turn_klass

  def initialize(board, legal_moves_klass=LegalMovesCalculator, turn_klass=ComputerTurn)
    @board = board
    @legal_moves = :uncalculated
    @current_turn = :untaken
    @turn_klass = turn_klass
    @legal_moves_klass = legal_moves_klass
  end

  def play
    odds_left? ? find_legal_moves : declare_outcome
  end

  def find_legal_moves
    @legal_moves = legal_moves_klass.new(board)
    right_move
    # legal_moves.any? ? right_move : declare_outcome
  end

  def right_move
    right_sized_chunk_available? ? next_turn : declare_outcome
  end

  def next_turn
    @current_turn = turn_klass.new(optimal_moves_available, board)
    # turn_klass.add(current_turn.slice_made)
    current_turn.slice_made.join(", ")
  end

  def optimal_moves_available
    even_sized_chunk_needed? ? legal_moves.even_sized : legal_moves.odd_sized
  end

  def right_sized_chunk_available?
    even_sized_chunk_needed? ? even_sized_chunk_available? : odd_sized_chunk_available?
  end

  def even_sized_chunk_available?
    legal_moves.even_sized_chunks_available.any?
  end

  def odd_sized_chunk_available?
    legal_moves.odd_sized_chunks_available.any?
  end

  def even_sized_chunk_needed?
    board.size.odd?
  end

  def odds_left?
    board.select {|x| x.odd?}.size
  end

end

# What i know about how it works.
# 1. you must leave an odd left. If there are no odds left you have lost
# 2. in order to leave an odd left against a computer also playing optimally
# you must slice so that there are an odd number left
# so if you start with an even sized array you must take an odd number
