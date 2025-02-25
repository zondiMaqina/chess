# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/chess_game'

RSpec.describe ChessGame do
  subject(:chess_game) { described_class.new }
  let(:board) { double('Board') }
  let(:white_pieces) { %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ ♟] }
  let(:black_pieces) { %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ ♙] }
  let(:chess_board) { Array.new(8) { Array.new(8, ' ') } }

  before do
    allow(chess_game).to receive(:board).and_return(board)
    allow(board).to receive(:chess_board).and_return(chess_board)
    allow(board).to receive(:white_pieces).and_return(white_pieces)
    allow(board).to receive(:black_pieces).and_return(black_pieces)
  end

  describe '#verify_moves' do
    context 'when piece has no valid moves' do
      before do
        allow(chess_game).to receive(:try_again)
        [3, 4, 5].each do |col|
          chess_board[3][col] = white_pieces[0]
        end
        chess_board[4][4] = '♟' # piece selected
        allow(chess_game).to receive(:chess_board).and_return(chess_board)
      end

      it 'will make player choose another piece' do
        position = 'e4'
        expect(chess_game).to receive(:try_again)
        chess_game.verify_moves(position, black_pieces, white_pieces)
      end
    end

    context 'when position has valid moves' do
      before do
        chess_board[1][4] = '♜' # selected piece
        allow(chess_game).to receive(:chess_board).and_return(chess_board)
      end

      it 'will let player select valid destination' do
        position = 'b4'
        message = "you have chosen a rook at #{position}"
        expect(chess_game).to receive(:puts).with(message)
        chess_game.verify_moves(position, black_pieces, white_pieces)
      end
    end
  end
end

# it will have to run the verify_moves to see if it will return any moves
# if it does not return any moves
# run try_again
# return true
