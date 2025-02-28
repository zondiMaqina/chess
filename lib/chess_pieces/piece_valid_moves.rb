# frozen_string_literal: true

# time complexity used for searching algorithms is Big O(n * v)
# where n is the amount of directions
# and v is the free space to gain valid moves on board

# module for searching all valid moves for each piece
module PieceMoves
  def rook_valid_moves(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    all_directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    all_directions.each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      while position_valid?(ref_row, ref_col)
        break if player_pieces.include?(chess_board[ref_row][ref_col])

        valid_moves << [ref_row, ref_col] if valid?(player_pieces, chess_board, ref_row, ref_col)
        break if opponent_pieces.include?(chess_board[ref_row][ref_col])

        ref_row += x
        ref_col += y
      end
    end
    valid_moves
  end

  def bishop_valid_moves(opponent_pieces, row, col, chess_board, player_pieces)
    valid_moves = []
    all_directions = [[-1, 1], [-1, -1], [1, 1], [1, -1]]
    all_directions.each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      while position_valid?(ref_row, ref_col)
        break if player_pieces.include?(chess_board[ref_row][ref_col])

        valid_moves << [ref_row, ref_col] if valid?(player_pieces, chess_board, ref_row, ref_col)
        break if opponent_pieces.include?(chess_board[ref_row][ref_col])

        ref_row += x
        ref_col += y
      end
    end
    valid_moves
  end

  def queen_valid_moves(opponent_pieces, player_pieces, chess_board, row, col)
    valid_moves = []
    all_directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, 1], [-1, -1], [1, 1], [1, -1]]
    all_directions.each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      while position_valid?(ref_row, ref_col)
        break if player_pieces.include?(chess_board[ref_row][ref_col])

        valid_moves << [ref_row, ref_col] if valid?(player_pieces, chess_board, ref_row, ref_col)
        break if opponent_pieces.include?(chess_board[ref_row][ref_col])

        ref_row += x
        ref_col += y
      end
    end
    valid_moves
  end

  def king_valid_moves(chess_board, row, col, player_pieces)
    all_valid_moves = []
    all_directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, 1], [-1, -1], [1, 1], [1, -1]]
    all_directions.each do |(x, y)|
      all_valid_moves << [row + x, col + y] if valid?(player_pieces, chess_board, row + x, col + y)
    end
    all_valid_moves
  end

  def pawn_valid_moves(opponent_pieces, row, col, chess_board, player_pieces)
    all_valid_moves = []
    all_directions = [[-1, 0], [-1, -1], [-1, 1]]
    all_directions.each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      if [x, y] == [-1, 0] && valid?(player_pieces, chess_board, ref_row, ref_col)
        all_valid_moves << [ref_row, ref_col] if chess_board[ref_row][ref_col] == ' '
      elsif ([x, y] == [-1, -1] || [x, y] == [-1, 1]) && valid?(player_pieces, chess_board, ref_row, ref_col)
        all_valid_moves << [ref_row, ref_col] if opponent_pieces.include?(chess_board[ref_row][ref_col])
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
      possible_moves << [ref_row, ref_col] if valid?(player_pieces, chess_board, ref_row, ref_col)
    end
    possible_moves
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
