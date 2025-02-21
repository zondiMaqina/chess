# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/chess_pieces/piece_valid_moves'

RSpec.describe PieceMoves do
  include PieceMoves

  let(:position) { [6, 3] }
  let(:player_pieces) { %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ ♟] }
  let(:opponent_pieces) { %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ ♙] }
  let(:chess_board) { Array.new(8) { Array.new(8, ' ') } }

  describe '#rook_valid_moves' do
    context 'when there are no pieces in valid moves' do
      it 'will return all valid moves on board' do
        valid_moves = rook_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(14)
      end
    end

    context 'when there are pieces in valid moves' do
      before do
        chess_board[3][3] = '♙'
        chess_board[6][1] = '♙'
        chess_board[6][4] = '♙'
      end

      it 'will return less valid moves' do
        valid_moves = rook_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end
  end

  describe '#bishop_valid_moves' do
    context 'when there are no pieces in valid moves' do
      it 'will return all valid moves on board' do
        valid_moves = bishop_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(9)
      end
    end

    context 'when there are pieces in valid moves' do
      before do
        chess_board[5][4] = '♙'
        chess_board[6][1] = '♙'
        chess_board[6][4] = '♙'
      end

      it 'will return less valid moves' do
        valid_moves = bishop_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(6)
      end
    end
  end

  describe '#queen_valid_moves' do
    context 'when there are no pieces in valid moves' do
      it 'will return all valid moves on board' do
        valid_moves = queen_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(23)
      end
    end

    context 'when there are pieces in valid moves' do
      before do
        chess_board[5][4] = '♙'
        chess_board[6][1] = '♙'
        chess_board[6][4] = '♙'
      end

      it 'will return less valid moves' do
        valid_moves = queen_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(16)
      end
    end
  end
end
