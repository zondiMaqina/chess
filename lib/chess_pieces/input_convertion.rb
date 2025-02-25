# forzen_string_literal: true
require_relative '../chess_pieces/players_pieces'
require_relative '../chess_pieces/piece_valid_moves'

# module for identifying the valid piece selected
class PieceSelection < PlayersPieces
  attr_reader :piece_name

  include PieceMoves

  def convert_position(position)
    @piece_name = nil
    identifiers.each do |name, pieces|
      @piece_name = name if pieces.include?(position)
    end
    piece_name
  end

  def find_valid_moves(opponent_pieces, position, chess_board, player_pieces)
    row = position[0]
    col = position[1]
    convert_position(chess_board[row][col])
    case piece_name
    when :pawn then pawn_valid_moves(opponent_pieces, row, col, chess_board, player_pieces)
    when :rook then rook_valid_moves(opponent_pieces, player_pieces, chess_board, row, col)
    when :knight then knight_valid_moves(row, col, chess_board, player_pieces)
    when :bishop then bishop_valid_moves(opponent_pieces, player_pieces, row, col, chess_board)
    when :king then king_valid_moves(chess_board, row, col, player_pieces)
    when :queen then queen_valid_moves(opponent_pieces, player_pieces, chess_board, row, col)
    end
  end
end
