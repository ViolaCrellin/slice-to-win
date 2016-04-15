require './lib/game.rb'

describe Game do
  let(:computer_klass) {double :computer_klass}
  let(:easy_board) {[1, 2]}
  subject(:game) {described_class.new(easy_board, computer_klass, computer_klass)}

  describe '#initialize' do

    it 'is initialized with the starting board' do
      
    end
  end
end
