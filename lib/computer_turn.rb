# responsible for looking at which first turns will win the game
# responsible for recording itself as the first turn in the game
class ComputerTurn

  class << self

    def turns
      @turns ||= {}
    end

    def add(slice_made)
      turns[turns.size] = slice_made
    end

    def find_first_turn
      turns[1]
    end

  end

  attr_accessor :slice_made

  def initialize(moves_available, board)
    @slice_made = make_choice(moves_available)
    @board = board
  end

  def make_choice(moves_available)
    moves_available.first.slice_position
  end

end
