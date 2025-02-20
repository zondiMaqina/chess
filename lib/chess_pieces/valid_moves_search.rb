# frozen_string_literal: true

# each searching algorithm stops as soon as it encounters a
# piece on the search path which helps with less time used (Big O(n)) through short-circuit evaluation

# module for searching next possible moves for each piece
module ValidMoves
  def valid_moves_up(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      row -= 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless position_empty?(chess_board, row, col)
    end
    valid_moves
  end

  def valid_moves_down(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      row += 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless valid?(chess_board, row, col)
    end
    valid_moves
  end

  def valid_moves_search_left(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col -= 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless valid?(chess_board, row, col)
    end
    valid_moves
  end

  def valid_moves_search_right(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col += 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless valid?(chess_board, row, col)
    end
    valid_moves
  end

  def valid_moves_diagonally_right_up(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col += 1
      row -= 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless valid?(chess_board, row, col)
    end
    valid_moves
  end

  def valid_moves_diagonally_right_down(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col += 1
      row += 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless valid?(chess_board, row, col)
    end
    valid_moves
  end

  def valid_moves_diagonally_left_up(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col -= 1
      row -= 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless valid?(chess_board, row, col)
    end
    valid_moves
  end

  def valid_moves_diagonally_left_down(chess_board, row, col)
    valid_moves = []
    while position_valid?(row, col)
      col -= 1
      row += 1
      valid_moves << [row, col] if valid?(chess_board, row, col)

      return valid_moves unless valid?(chess_board, row, col)
    end
    valid_moves
  end

  def valid?(chess_board, row, col)
    position_valid?(row, col) && position_empty?(chess_board, row, col)
  end

  def position_valid?(row, col)
    # checks position coordinates are still within board
    row.between?(0, 7) && col.between?(0, 7)
  end

  def position_empty?(chess_board, row, col)
    chess_board[row][col].match(' ')
  end
end
