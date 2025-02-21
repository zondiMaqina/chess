# frozen_string_literal: true

require_relative 'valid_moves_search'

# the time complexity of these methods should be studied :(

# module for searching all valid moves for each piece
module PieceMoves
  include ValidMoves

  def rook_valid_moves(player_pieces, chess_board, row, col)
    all_valid_moves = []
    all_valid_moves << valid_moves_up(player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_down(player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_search_left(player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_search_right(player_pieces, chess_board, row, col)
    all_valid_moves.flatten(1)
  end
end

# rook => up, down, left, right
# bishop => diagonal_right_up, diagonal_right_down, diagonal_left_up, diagonal_left_down
# queen => all of them
# knight => 2 moves forward, 1 move left
# pawh => one move forward or one move diagonal_left or diagnoal_right or two moves forward
# king all of them, one move

# PAWN
# moves diagonal when piece exits on next position
# moves two moves forward if it is not moves yet
