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

  def pawn_valid_moves(all_directions, row, col, chess_board, player_pieces)
    all_valid_moves = []
    all_directions.each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      if [x, y] == [-1, 0] && still_valid?(ref_row, ref_col, chess_board, player_pieces)
        all_valid_moves << [ref_row, ref_col] if chess_board[ref_row][ref_col] == ' '
      elsif [x, y] == [-1, -1] && occupied?(ref_row, ref_col, chess_board, player_pieces)
        all_valid_moves << [ref_row, ref_col]
      elsif [x, y] == [-1, 1] && occupied?(ref_row, ref_col, chess_board, player_pieces)
        all_valid_moves << [ref_row, ref_col]
      end
    end
    all_valid_moves
  end

  def knight_valid_moves(row, col, chess_board, player_pieces)
    maximum_possible_displacements = [[-2, -1], [-2, 1], [2, -1], [2, 1], [1, -2], [-1, -2], [-1, 2], [1, 2]]
    possible_moves = []
    maximum_possible_displacements.each do |move|
      ref_row = row + move[0]
      ref_col = col + move[1]
      possible_moves << [ref_row, ref_col] if still_valid?(ref_row, ref_col, chess_board, player_pieces)
    end
    possible_moves
  end

  def still_valid?(row, col, chess_board, player_pieces)
    row.between?(0, 7) && col.between?(0, 7) && !player_pieces.include?(chess_board[row][col])
  end

  def occupied?(row, col, chess_board, player_pieces)
    still_valid?(row, col, chess_board, player_pieces) && !chess_board[row][col].match(' ')
  end
end
