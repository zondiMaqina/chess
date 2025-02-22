# frozen_string_literal: true

# each searching algorithm stops as soon as it encounters an
# opponent's piece on the search path which helps with less time used (Big O(n)) through short-circuit evaluation

# module for searching next possible moves for each piece
module ValidMoves
  def valid_moves_up(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      row -= 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless position_empty?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid_moves_down(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      row += 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless valid?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid_moves_search_left(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col -= 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless valid?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid_moves_search_right(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col += 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless valid?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid_moves_diagonally_right_up(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col += 1
      row -= 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless valid?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid_moves_diagonally_right_down(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col += 1
      row += 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless valid?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid_moves_diagonally_left_up(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col -= 1
      row -= 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless valid?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid_moves_diagonally_left_down(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col -= 1
      row += 1
      valid_moves << [row, col] if valid?(player_pieces, chess_board, row, col)

      return valid_moves unless valid?(player_pieces, chess_board, row, col)
      break if opponent_pieces.include?(chess_board[row][col])
    end
    valid_moves
  end

  def valid?(player_pieces, chess_board, row, col)
    position_valid?(row, col) && position_empty?(player_pieces, chess_board, row, col)
  end

  def position_valid?(row, col)
    row.between?(0, 7) && col.between?(0, 7)
  end

  def position_empty?(player_pieces, chess_board, row, col)
    position = chess_board[row][col]
    !player_pieces.include?(position)
  end
end
