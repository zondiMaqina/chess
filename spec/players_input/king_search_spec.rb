# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/chess_pieces/king_search'

RSpec.describe 'KingSafety' do
  include KingSafety
  let(:king) { '♚' }
  let(:chess_board) { Array.new(8) { Array.new(8, ' ') } }
  let(:player_pieces) { %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜] }
  let(:opp_pieces) { %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖] }

  describe '#king_search' do
    before do
      chess_board[7][4] = king
    end

    it 'will search the position of king targeted' do
      position_found = king_search(king, chess_board)
      expect(position_found).to eql([7, 4])
    end
  end

  describe '#vertically_safe?' do
    context 'when no piece is in path' do
      it 'king is safe' do
        king_pos = [4, 4]
        king_safety = vertically_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(true)
      end
    end

    context 'when there is threat behind allied piece' do
      before do
        chess_board[3][4] = player_pieces[4]
        chess_board[2][4] = opp_pieces[3]
      end

      it 'king will still be safe' do
        king_pos = [4, 4]
        king_safety = vertically_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(true)
      end
    end

    context 'when there is threat on path' do
      before do
        chess_board[2][4] = opp_pieces[3]
        chess_board[5][4] = player_pieces[0]
      end

      it 'king will not be safe' do
        king_pos = [4, 4]
        king_safety = vertically_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(false)
      end
    end
  end

  describe '#horizontally_safe?' do
    context 'when no piece is in path' do
      it 'king will be safe' do
        king_pos = [4, 4]
        king_safety = horizontally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(true)
      end
    end

    context 'when there is threat behind allied piece' do
      before do
        chess_board[4][6] = player_pieces[4]
        chess_board[4][7] = opp_pieces[3]
      end

      it 'king will still be safe' do
        king_pos = [4, 4]
        king_safety = horizontally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(true)
      end
    end

    context 'when there is threat on path' do
      before do
        chess_board[4][6] = opp_pieces[3]
      end

      it 'king will not be safe' do
        king_pos = [4, 4]
        king_safety = horizontally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(false)
      end
    end
  end

  describe '#diagonally_safe?' do
    context 'when no piece is in path' do
      before do
        chess_board[3][3] = player_pieces[3]
        chess_board[5][5] = player_pieces[3]
      end

      it 'king will be safe' do
        king_pos = [4, 4]
        king_safety = diagonally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(true)
      end
    end

    context 'when there is threat behind allied piece' do
      before do
        chess_board[3][3] = player_pieces[4]
        chess_board[5][5] = player_pieces[3]
        chess_board[6][6] = opp_pieces[3]
      end

      it 'king will still be safe' do
        king_pos = [4, 4]
        king_safety = diagonally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(true)
      end
    end

    context 'when there is threat on path' do
      before do
        chess_board[2][2] = opp_pieces[3]
      end

      it 'king will not be safe' do
        king_pos = [4, 4]
        king_safety = diagonally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(false)
      end
    end
  end

  describe '#king_checked?' do
    context 'when threat exists horizontally' do
      before do
        chess_board[4][5] = opp_pieces[0]
      end

      it 'king is not safe' do
        king_pos = [4, 4]
        king_safety = king_checked?(player_pieces, chess_board, king_pos, opp_pieces)
        expect(king_safety).to eql(true)
      end
    end
  end

  let(:opp_king) { opp_pieces[4] }

  describe '#check_move?' do
    context 'when move made leads to opp king' do
      before do
        chess_board[0][0] = opp_king
        chess_board[2][1] = player_pieces[1]
      end

      it 'king will be checked' do
        pos = [2, 1]
        king_check = check_move?(opp_pieces, pos, chess_board, player_pieces)
        expect(king_check).to eql(true)
      end
    end

    context 'when move does not lead to opp king' do
      before do
        chess_board[0][1] = opp_king
        chess_board[4][4] = player_pieces[2]
      end

      it 'king is safe' do
        pos = [4, 4]
        king_check = check_move?(opp_pieces, pos, chess_board, player_pieces)
        expect(king_check).to eql(false)
      end
    end
  end

  describe '#check_mate?' do
    context 'when opp king has only queen checking' do
      before do
        chess_board[0][0] = opp_king
        chess_board[1][1] = player_pieces[3]
      end

      it 'it is not check mate' do
        check_mate = check_mate?(opp_pieces, chess_board, player_pieces)
        expect(check_mate).to eql(false)
      end
    end

    context 'when opp king is checked by queen that is protected by rook' do
      before do
        chess_board[0][0] = opp_king
        chess_board[1][1] = player_pieces[3]
        chess_board[2][1] = player_pieces[0]
      end

      it 'it is checkmate' do
        check_mate = check_mate?(opp_pieces, chess_board, player_pieces)
        expect(check_mate).to eql(true)
      end
    end

    context 'when king is blocked by allied pieces and checked' do
      before do
        chess_board[0][0] = opp_king
        chess_board[0][1] = opp_pieces[2]
        chess_board[1][1] = opp_pieces[2]
        chess_board[3][0] = player_pieces[0]
      end

      it 'is checkmate' do
        check_mate = check_mate?(opp_pieces, chess_board, player_pieces)
        expect(check_mate).to eql(true)
      end
    end

    context 'when opp king is blocked by allied pieces' do
      before do
        chess_board[0][0] = opp_king
        chess_board[1][0] = opp_pieces[0]
        chess_board[3][3] = player_pieces[3]
        chess_board[0][1] = opp_pieces[2]
      end

      it 'is not checkmate' do
        check_mate = check_mate?(opp_pieces, chess_board, player_pieces)
        expect(check_mate).to eql false
      end
    end
  end
end
