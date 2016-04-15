require './lib/game.rb'

describe Game do
  let(:legal_moves_klass) {double(:legal_moves_klass, new: legal_moves)}
  let(:turn_klass) {double(:turn_klass, new: turn, add: turn, turns: {})}
  let(:move) {double :move}
  subject(:game) {described_class.new(easy_board, legal_moves_klass, turn_klass)}

  # allow(die).to receive(:roll).and_return(1, 2, 3) => order of returned will be 1, 2, 3


  context 'easy game' do
    let(:legal_moves) {double(:legal_moves, odd_sized: [move], even_sized: [])}
    let(:turn) {double(:turn, slice_choice: [1, 1], update_board: [1])}
    # let(:turn_klass) {double(:turn_klass, new: turn)}

    let(:easy_board) {[1, 2]}
    let(:game_double) { game }


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

      it 'has access to a turn_klass object to retrieve info about turns' do
        expect(game.turn_klass).to eq(turn_klass)
      end
    end

    describe '#play' do

      it 'finds out if there are any odds on the current board - needed to win' do
        allow(turn).to receive(:update_board).and_return([1])
        expect(game).to receive(:odds_left?).exactly(2).times.and_call_original
        game.play
      end

      it 'it will then find legal moves only if there are some odds left' do
        allow(game).to receive(:odds_left?).and_return(false)
        expect(game).not_to receive(:find_legal_moves)
        game.play
      end
    end

    describe '#find_legal_moves' do

      # before do
      #   game.send(:find_legal_moves)
      # end

      it 'creates a new legal moves calculator to calculate the legal moves' do
        expect(legal_moves_klass).to receive(:new).with(game.board)
        game.send(:find_legal_moves)
      end

      it 'updates the games\' legal moves attribute' do
        game.send(:find_legal_moves)
        expect(game.legal_moves).to eq(legal_moves)
      end

      it 'with the legal move calculations it decides if a new turn is necessary' do
        expect(game).to receive(:next_turn)
        game.send(:find_legal_moves)
      end

      it 'not prompt next turn if no legal move found, instead will declare outcome' do
        allow(game).to receive(:right_sized_chunk_available?).and_return(false)
        expect(game).not_to receive(:next_turn)
        expect(game).to receive(:declare_outcome)
        game.send(:find_legal_moves)
      end

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
