# frozen_string_literal: true

require_relative '../../lib/chess_pieces/valid_moves_search'
require_relative '../spec_helper'

RSpec.describe 'ValidMoves' do
  include ValidMoves

  let(:chess_board) { Array.new(8) { Array.new(8, ' ') } }
  let(:position) { [5, 0] }
  let(:player_pieces) { %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ ♟] }
  describe '#valid_moves_up' do
    context 'when given position is in empty path' do
      it 'will return all valid moves on' do
        row = position[0]
        col = position[1]
        valid_moves = valid_moves_up(player_pieces, chess_board, row, col)
        expect(valid_moves.size).to eql(5)
      end
    end

    context 'when given position is on top' do
      it 'will return no valid moves' do
        position = [0, 1]
        valid_moves = valid_moves_up(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when position has a piece on next valid move' do
      before do
        chess_board[4][0] = '♟'
      end

      it 'will return no valid move' do
        position = [5, 0]
        valid_moves = valid_moves_up(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe '#valid_moves_down' do
    context 'when given position is on empty path' do
      it 'will get all valid moves on path' do
        position = [0, 0]
        valid_moves = valid_moves_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when given position is at the bottom' do
      it 'will not return further valid moves' do
        position = [7, 0]
        valid_moves = valid_moves_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when there is a piece on top of position' do
      before do
        chess_board[5][0] = '♟'
      end

      it 'will not return valid moves' do
        position = [4, 0]
        valid_moves = valid_moves_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe '#valid_moves_search_left' do
    context 'when given position has an empty path' do
      it 'will return all valid moves on path' do
        position = [2, 7]
        valid_moves = valid_moves_search_left(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when given position is at furthest edge' do
      it 'will not return valid moves' do
        position = [0, 0]
        valid_moves = valid_moves_search_left(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when given position has a piece next to it' do
      before do
        chess_board[0][3] = '♟'
      end

      it 'will not return further valid_moves' do
        position = [0, 4]
        valid_moves = valid_moves_search_left(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe '#valid_moves_right' do
    context 'when given position is on empty path' do
      it 'wil return all valid moves on path' do
        position = [0, 0]
        valid_moves = valid_moves_search_right(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when given position is on edge of board' do
      it 'wil not return further valid moves' do
        position = [0, 7]
        valid_moves = valid_moves_search_right(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when given position has piece next to it' do
      before do
        chess_board[0][6] = '♟'
      end

      it 'wil not return further valid moves' do
        position = [0, 7]
        valid_moves = valid_moves_search_right(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe '#valid_moves_diagonally_right_up' do
    context 'when given position is on empty path' do
      it 'will return all valid_moves on path' do
        position = [7, 0]
        valid_moves = valid_moves_diagonally_right_up(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when given position is at edge of board' do
      it 'will not return further valid moves' do
        position = [0, 7]
        valid_moves = valid_moves_search_right(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when given position has piece next to it' do
      before do
        chess_board[1][5] = '♟'
      end

      it 'wil not return further valid moves' do
        position = [2, 4]
        valid_moves = valid_moves_diagonally_right_up(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe 'valid_moves_diagonally_right_down' do
    context 'when given position is on empty path' do
      it 'will return all valid_moves on path' do
        position = [0, 0]
        valid_moves = valid_moves_diagonally_right_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when given position is at edge of board' do
      it 'will not return further valid moves' do
        position = [7, 7]
        valid_moves = valid_moves_diagonally_right_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when given position has piece next to it' do
      before do
        chess_board[4][6] = '♟'
      end

      it 'wil not return further valid moves' do
        position = [3, 5]
        valid_moves = valid_moves_diagonally_right_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe 'valid_moves_diagonally_left_up' do
    context 'when given position is on empty path' do
      it 'will return all valid_moves on path' do
        position = [7, 7]
        valid_moves = valid_moves_diagonally_left_up(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when given position is at edge of board' do
      it 'will not return further valid moves' do
        position = [7, 0]
        valid_moves = valid_moves_diagonally_left_up(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when given position has piece next to it' do
      before do
        chess_board[4][4] = '♟'
      end

      it 'wil not return further valid moves' do
        position = [5, 5]
        valid_moves = valid_moves_diagonally_left_up(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe 'valid_moves_diagonally_left_down' do
    context 'when given position is on empty path' do
      it 'will return all valid_moves on path' do
        position = [0, 7]
        valid_moves = valid_moves_diagonally_left_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when given position is at edge of board' do
      it 'will not return further valid moves' do
        position = [7, 0]
        valid_moves = valid_moves_diagonally_left_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when given position has piece next to it' do
      before do
        chess_board[1][4] = '♟'
      end

      it 'wil not return further valid moves' do
        position = [0, 5]
        valid_moves = valid_moves_diagonally_left_down(player_pieces, chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end
end
