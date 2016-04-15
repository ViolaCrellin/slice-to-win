# responsible for initializing the game with the board.
# responsible for calling new situation_assessment
# will assign players to the classes they have access to.
# ComputerPlayer will be able to access legal moves calculator and computerturn

class Game

  def initialize(board, player1=ComputerPlayer, player2=ComputerPlayer)
    @board = board
    @player1 = player1
    @player2 = player2
  end


end
