# frozen_string_literal: true

require_relative 'piece_valid_moves'
require_relative 'input_convertion'

# module for controlling the safety of the king piece
module KingSafety
  include PieceMoves
  # finds the position of the king targeted
  def king_search(king, chess_board)
    position = []
    chess_board.each_with_index do |row, index|
      if row.include?(king)
        position << index
        position << row.index(king)
      end
    end
    position
  end

  def king_checked?(player_pieces, chess_board, king_pos, opp_pieces)
    [vertically_safe?(player_pieces, chess_board, king_pos, opp_pieces),
     horizontally_safe?(player_pieces, chess_board, king_pos, opp_pieces),
     diagonally_safe?(player_pieces, chess_board, king_pos, opp_pieces)].any? { |safety| safety == false }
  end

  def vertically_safe?(player_pieces, chess_board, king_pos, opp_pieces)
    safe = true
    [[-1, 0], [1, 0]].each do |(x, y)|
      ref_row = king_pos[0] + x
      ref_col = king_pos[1] + y
      while position_valid?(ref_row, ref_col)
        break if player_pieces.include?(chess_board[ref_row][ref_col])

        safe = false if position_valid?(ref_row, ref_col) && matched_v?(chess_board[ref_row][ref_col], opp_pieces)

        break if player_pieces.include?(chess_board[ref_row][ref_col])

        ref_row += x
        ref_col += y
      end
      break unless safe
    end
    safe
  end

  def horizontally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
    safe = true
    [[0, 1], [0, -1]].each do |(x, y)|
      ref_row = king_pos[0] + x
      ref_col = king_pos[1] + y
      while position_valid?(ref_row, ref_col)
        break if player_pieces.include?(chess_board[ref_row][ref_col])

        safe = false if position_valid?(ref_row, ref_col) && matched_h?(chess_board[ref_row][ref_col], opp_pieces)

        break if player_pieces.include?(chess_board[ref_row][ref_col])

        ref_row += x
        ref_col += y
      end
      break unless safe
    end
    safe
  end

  def diagonally_safe?(player_pieces, chess_board, king_pos, opp_pieces)
    safe = true
    [[-1, -1], [1, 1], [-1, 1], [1, -1]].each do |(x, y)|
      ref_row = king_pos[0] + x
      ref_col = king_pos[1] + y
      while position_valid?(ref_row, ref_col)
        break if player_pieces.include?(chess_board[ref_row][ref_col])

        safe = false if position_valid?(ref_row, ref_col) && matched_d?(chess_board[ref_row][ref_col], opp_pieces)

        break if player_pieces.include?(chess_board[ref_row][ref_col])

        ref_row += x
        ref_col += y
      end
      break unless safe
    end
    safe
  end

  def matched_v?(position, opp_pieces)
    position == opp_pieces[0] || position == opp_pieces[3]
  end

  def matched_d?(position, opp_pieces)
    position == opp_pieces[3] || position == opp_pieces[2]
  end

  def matched_h?(position, opp_pieces)
    position == opp_pieces[0] || position == opp_pieces[3]
  end

  def check_move?(opp_pieces, pos, chess_board, player_pieces)
    piece_selection = PieceSelection.new
    moves = piece_selection.find_valid_moves(opp_pieces, pos, chess_board, player_pieces)
    opp_king = opp_pieces[4]
    return true if moves.include?(king_search(opp_king, chess_board))

    false
  end

  # searching from the opponent's perspective
  def check_mate?(opp_pieces, chess_board, player_pieces)
    opp_king_pos = king_search(opp_pieces[4], chess_board)
    selection = PieceSelection.new
    next_valid_moves = selection.king_valid_moves(chess_board, opp_king_pos[0], opp_king_pos[1], opp_pieces)

    next_valid_moves.all? do |move|
      king_checked?(opp_pieces, chess_board, move, player_pieces) == true
    end
  end
end
