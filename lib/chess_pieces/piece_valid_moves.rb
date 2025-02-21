# frozen_string_literal: true

require_relative 'valid_moves_search'

# the time complexity of these methods should be studied :(

# module for searching all valid moves for each piece
module PieceMoves
  include ValidMoves

  def rook_valid_moves(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves = []
    all_valid_moves << valid_moves_up(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_down(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_search_left(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_search_right(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves.flatten(1)
  end

  def bishop_valid_moves(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves = []
    all_valid_moves << valid_moves_diagonally_right_up(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_diagonally_right_down(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_diagonally_left_up(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_diagonally_left_down(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves.flatten(1)
  end

  def queen_valid_moves(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves = []
    all_valid_moves << horizontally_vertically(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_diagonally_right_up(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_diagonally_right_down(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_diagonally_left_up(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_diagonally_left_down(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves.flatten(1)
  end

  def horizontally_vertically(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves = []
    all_valid_moves << valid_moves_up(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_down(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_search_left(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves << valid_moves_search_right(opponent_pieces, player_pieces, chess_board, row, col)
    all_valid_moves.flatten(1)
  end
end

# pawh => one move forward or one move diagonal_left or diagnoal_right or two moves forward
# king all of them, one move

# PAWN
# moves diagonal when piece exits on next position
# moves two moves forward if it is not moves yet
