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

  def king_valid_moves(all_directions, chess_board, row, col, player_pieces)
    all_valid_moves = []
    all_directions.each do |(x, y)|
      all_valid_moves << [row + x, col + y] if still_valid?(row + x, col + y, chess_board, player_pieces)
    end
    all_valid_moves
  end

  def still_valid?(row, col, chess_board, player_pieces)
    row.between?(0, 7) && col.between?(0, 7) && !player_pieces.include?(chess_board[row][col])
  end

  def occupied?(row, col, chess_board, player_pieces)
    still_valid(row, col, chess_board, player_pieces) && !chess_board[row][col].match(' ')
  end
end
