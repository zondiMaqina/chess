# frozen_string_literal: true

require_relative '../../lib/input_handling/position_validity'
require_relative '../spec_helper'

RSpec.describe PositionValidity do
  # initalize => assigns object(s)
  # board_position_valid? => Public Script method
  subject(:player_selection) { described_class.new }
  let(:chess_board) { Array.new(8) {Array.new(8, ' ')} }
  let(:position) { 'a2' }
  let(:chess_pieces) {%w[♟ ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜]}

  describe '#position_yours?' do
    context 'when input leads to empty position on board' do
      it 'will return false' do
        result = player_selection.position_yours?(chess_board, position, chess_pieces)
        expect(result).to be false
      end
    end

    context 'when player selects their own piece' do
      before do
        chess_board[1][4] = '♟'
      end

      it 'will return true' do
        position = 'b4'
        result = player_selection.position_yours?(chess_board, position, chess_pieces)
        expect(result).to be true
      end
    end

    context "when player selects opponent's piece" do
      before do
        chess_board[6][5] = '♙'
      end

      it 'will return false' do
        position = 'g5'
        result = player_selection.position_yours?(chess_board, position, chess_pieces)
        expect(result).to be false
      end
    end
  end
end
