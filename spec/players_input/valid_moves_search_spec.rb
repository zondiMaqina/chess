# frozen_string_literal: true

require_relative '../../lib/chess_pieces/valid_moves_search'
require_relative '../spec_helper'

RSpec.describe 'ValidMoves' do
  include ValidMoves

  let(:chess_board) { Array.new(8) { Array.new(8, ' ') } }
  let(:position) { [5, 0] }

  describe '#valid_moves_up' do
    context 'when given position is in empty path' do
      it 'will return all valid moves on' do
        row = position[0]
        col = position[1]
        valid_moves = valid_moves_up(chess_board, row, col)
        expect(valid_moves.size).to eql(5)
      end
    end

    context 'when given position is on top' do
      it 'will return no valid moves' do
        position = [0, 1]
        valid_moves = valid_moves_up(chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end

    context 'when position has a piece on next valid move' do
      before do
        chess_board[4][0] = '♟'
      end

      it 'will return no valid move' do
        position = [5, 0]
        p valid_moves = valid_moves_up(chess_board, position[0], position[1])
        expect(valid_moves).to be_empty
      end
    end
  end

  describe '#valid_moves_down' do
    context 'when given position is on empty path' do
      it 'will get all valid moves on path' do
        position = [0, 0]
        row = position[0]
        col = position[1]
        valid_moves = valid_moves_down(chess_board, row, col)
        expect(valid_moves.size).to eql(7)
      end
    end

    context 'when at given position is at the bottom' do
      it 'will not return further valid moves' do
        position = [7, 0]
        row = position[0]
        col = position[1]
        valid_moves = valid_moves_down(chess_board, row, col)
        expect(valid_moves).to be_empty
      end
    end

    context 'when there is a piece on top of position' do
      before do
        chess_board[5][0] = '♟'
      end

      it 'will not return valid moves' do
        position = [4, 0]
        row = position[0]
        col = position[1]
        valid_moves = valid_moves_down(chess_board, row, col)
        expect(valid_moves).to be_empty
      end
    end
  end

  describe '#valid_moves_left' do
  end

  describe '#valid_moves_right' do
  end

  describe '#valid_moves_diagonally_right_up' do
  end

  describe 'valid_moves_diagonally_right_down' do
  end

  describe 'valid_moves_diagonally_left_up' do
  end

  describe 'valid_moves_diagonally_left_down' do
  end
end
