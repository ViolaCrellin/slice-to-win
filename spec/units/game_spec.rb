require './lib/game.rb'

describe Game do
  let(:legal_moves_klass) {double :legal_moves_klass}
  let(:turn_klass) {double :turn_klass}

  let(:easy_board) {[1, 2]}
  subject(:game) {described_class.new(easy_board, legal_moves_klass, turn_klass)}

  describe '#initialize' do

    it 'is initialized with the starting board' do
      expect(game.board).to eq(easy_board)
    end

    it 'has a LegalMovesCalculator ready to recalculate legal moves with' do
      expect(game.legal_moves_klass).to eq(legal_moves_klass)
    end

    it 'initially has legal_moves as :uncalculated' do
      expect(game.legal_moves).to eq(:uncalculated)
    end

    it 'initially has current_turn as :untaken' do
      expect(game.current_turn).to eq(:untaken)
    end

  end
end

# context 'Class methods' do
#
#
#   describe '.players' do
#
#     it 'stores @players when .add is called' do
#       expect{player.add(player_id, player_name)}.to change{player.players.size}.by(1)
#     end
#   end
#
#   describe '.add' do
#
#     before do
#       player.add(player_id, player_name)
#     end
#
#     it '.adds a Player class object to the @players hash' do
#       expect(player.players).to include ({player_id => player_name})
#     end
#   end
#
#   describe '.look_up' do
#
#     before do
#       player.add(player_id, player_name)
#     end
#
#     it 'will .look_up a Player class object' do
#       expect(player.look_up(player_id)).to eq player_name
#     end
#   end
# end
