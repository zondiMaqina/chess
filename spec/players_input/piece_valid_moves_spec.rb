# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/chess_pieces/piece_valid_moves'

RSpec.describe PieceMoves do
  include PieceMoves

  let(:position) { [6, 3] }
  let(:player_pieces) { %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ ♟] }
  let(:opponent_pieces) { %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ ♙] }
  let(:chess_board) { Array.new(8) { Array.new(8, ' ') } }
  let(:all_directions) { [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [1, 1], [-1, 1], [1, -1]] }

  describe '#rook_valid_moves' do
    context 'when there are no pieces in valid moves' do
      it 'will return all valid moves on board' do
        valid_moves = rook_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(14)
      end
    end

    context 'when there are pieces in valid moves' do
      before do
        chess_board[3][3] = player_pieces[2]
        chess_board[6][1] = player_pieces[0]
        chess_board[6][4] = player_pieces[1]
      end

      it 'will return less valid moves' do
        valid_moves = rook_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(4)
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

    context 'when there are allied pieces in valid moves' do
      before do
        chess_board[5][4] = player_pieces[5]
      end

      it 'will return less valid moves' do
        valid_moves = bishop_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(5)
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

    context 'when there are allied pieces in valid moves' do
      before do
        [4, 2].each do |col|
          chess_board[5][col] = '♟'
        end
      end

      it 'will return less valid moves' do
        valid_moves = queen_valid_moves(opponent_pieces, player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(16)
      end
    end
  end

  describe '#king_valid_moves' do
    context 'when king has all space to move' do
      it 'will return 5 valid moves' do
        position = [4, 4]
        valid_moves = king_valid_moves(chess_board, position[0], position[1], opponent_pieces)
        expect(valid_moves.size).to eql(8)
      end
    end

    context 'when the king has allied pieces blocking it' do
      before do
        chess_board[6][4] = player_pieces[0]
        chess_board[7][3] = player_pieces[1]
      end

      it 'will return less valid moves' do
        position = [7, 4]
        valid_moves = king_valid_moves(chess_board, position[0], position[1], player_pieces)
        expect(valid_moves.size).to eql(3)
      end
    end
  end

  describe '#pawn_valid_moves' do
    context 'when pawn has all spaces to move' do
      it 'will only return one move' do
        position = [4, 4]
        row = position[0]
        col = position[1]
        all_directions = [[-1, 0], [-1, 1], [-1, -1]]
        valid_moves = pawn_valid_moves(opponent_pieces, row, col, chess_board, player_pieces)
        expect(valid_moves.size).to eql(1)
      end
    end

    context 'when there are allied pieces ahead' do
      before do
        [3, 4, 5].each do |col|
          chess_board[3][col] = player_pieces[3]
        end
      end

      it 'will return no valid moves' do
        position = [4, 4]
        row = position[0]
        col = position[1]
        all_directions = [[-1, 0], [-1, 1], [-1, -1]]
        valid_moves = pawn_valid_moves(opponent_pieces, row, col, chess_board, player_pieces)
        expect(valid_moves).to be_empty
      end
    end

    context 'when there are 2 pieces to consume' do
      before do
        [3, 5].each do |col|
          chess_board[3][col] = opponent_pieces[3]
        end
      end

      it 'will return 3 valid moves' do
        position = [4, 4]
        row = position[0]
        col = position[1]
        all_directions = [[-1, 0], [-1, -1], [-1, 1]]
        valid_moves = pawn_valid_moves(opponent_pieces, row, col, chess_board, player_pieces)
        expect(valid_moves.size).to eql(3)
      end
    end
  end

  describe '#kight_valid_moves' do
    context 'when knight has all spaces to move' do
      it 'will return all valid moves' do
        position = [4, 4]
        valid_moves = knight_valid_moves(position[0], position[1], chess_board, player_pieces)
        expect(valid_moves.size).to eql(8)
      end
    end

    context 'when allied pieces are present' do
      before do
        [3, 5].each do |col|
          chess_board[6][col] = player_pieces[0]
        end
      end

      it 'will return less valid moves' do
        position = [4, 4]
        valid_moves = knight_valid_moves(position[0], position[1], chess_board, player_pieces)
        expect(valid_moves.size).to eql(6)
      end
    end
  end
end
