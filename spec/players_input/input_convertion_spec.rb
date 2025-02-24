# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/chess_pieces/input_convertion'

RSpec.describe PieceSelection do
  subject(:position_selected) { described_class.new }
  let(:player_pieces) { %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ ♟] }
  let(:opponent_pieces) { %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖ ♙] }
  let(:chess_board) { Array.new(8) { Array.new(8, ' ') } }
  let(:all_directions) { [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [1, 1], [-1, 1], [1, -1]] }

  describe '#convert_position' do
    context 'when position selected is a piece' do
      it "will return the piece's name" do
        position = '♟'
        name = :pawn
        piece_name = position_selected.convert_position(position)
        expect(piece_name).to eql(name)
      end
    end

    context 'when selected position is a rook' do
      it "will return piece's name" do
        position = '♙'
        name = :pawn
        piece_name = position_selected.convert_position(position)
        expect(piece_name).to eql(name)
      end
    end
  end

  describe '#find_valid_moves' do
    context 'when piece name is given' do
      before do
        allow(position_selected).to receive(:pawn_valid_moves)
        chess_board[4][4] = '♙'
      end

      it 'will return all valid moves' do
        position = [4, 4]
        expect(position_selected).to receive(:pawn_valid_moves)
        position_selected.find_valid_moves(opponent_pieces, all_directions, position, chess_board, player_pieces)
      end
    end
  end
end
