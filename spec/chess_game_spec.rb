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
        position = [4, 4]
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
        position = [1, 4]
        message = 'you have chosen a rook at b4'
        expect(chess_game).to receive(:puts).with(message)
        chess_game.verify_moves(position, black_pieces, white_pieces)
      end
    end
  end

  describe '#verify_validity' do
    context 'when player move is empty space' do
      it 'player will play valid move again' do
        position = 'e1'
        expect(chess_game).to receive(:try_again)
        chess_game.verify_validity(position, chess_board, white_pieces, black_pieces)
      end
    end

    context 'when player move is opponent piece' do
      before do
        chess_board[5][1] = black_pieces[3]
      end

      it 'player will play valid move again' do
        position = 'f1'
        expect(chess_game).to receive(:try_again)
        chess_game.verify_validity(position, chess_board, white_pieces, black_pieces)
      end
    end

    context 'when player move is their piece' do
      before do
        chess_board[1][2] = white_pieces[3]
      end

      it 'will verify if it is has moves' do
        position = 'b2'
        expect(chess_game).to receive(:verify_moves)
        chess_game.verify_validity(position, chess_board, white_pieces, black_pieces)
      end
    end
  end

  describe '#verify_input' do
    context 'when input has more than 3 char' do
      it 'will ask player to enter move again' do
        invalid_input = '#4'
        expect(chess_game).to receive(:try_again)
        chess_game.verify_input(invalid_input, chess_board, white_pieces, black_pieces)
      end
    end

    context 'when input is valid' do
      it 'will verify if move has next valid moves' do
        input = 'e5'
        expect(chess_game).to receive(:verify_validity)
        chess_game.verify_input(input, chess_board, white_pieces, black_pieces)
      end
    end
  end
end

# accepts player input
# if it does not meet standards
# it will make them try again
# it will verify its validity on board
