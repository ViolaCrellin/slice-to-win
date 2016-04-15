# responsible for deciding if a win is possible at all
# responsible for deciding whos turn it is and whether it is the first turn

# calls legal moves calculator if there is an opportunity to win.
class StatusChecker

  # attr_reader :legal_moves
  #
  def initialize(legal_moves, board)
    @status = assess_status(legal_moves, board)
  end
  #
  # def assess_status
  #
  # end

end
