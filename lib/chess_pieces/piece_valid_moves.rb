# frozen_string_literal: true

# each method finds all valid moves for each piece to play using all possible directions it can play next on board

# module for searching all valid moves for each piece
module PieceMoves
  # row and col refer to piece's current position on board
  def rook_valid_moves(player_pieces, chess_board, row, col)
    valid_moves = []
    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      while valid?(player_pieces, chess_board, ref_row, ref_col)
        valid_moves << [ref_row, ref_col]
        ref_row += x
        ref_col += y
      end
    end
    valid_moves
  end

  def bishop_valid_moves(row, col, chess_board, player_pieces)
    valid_moves = []
    [[-1, 1], [-1, -1], [1, 1], [1, -1]].each do |(x, y)|
      ref_row = row + x # 5
      ref_col = col + y # 4
      while valid?(player_pieces, chess_board, ref_row, ref_col)
        valid_moves << [ref_row, ref_col]
        ref_row += x
        ref_col += y
      end
    end
    valid_moves
  end

  def queen_valid_moves(player_pieces, chess_board, row, col)
    valid_moves = []
    [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, 1], [-1, -1], [1, 1], [1, -1]].each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      while valid?(player_pieces, chess_board, ref_row, ref_col)
        valid_moves << [ref_row, ref_col]
        ref_row += x
        ref_col += y
      end
    end
    valid_moves
  end

  def king_valid_moves(chess_board, row, col, player_pieces)
    all_valid_moves = []
    [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, 1], [-1, -1], [1, 1], [1, -1]].each do |(x, y)|
      all_valid_moves << [row + x, col + y] if valid?(player_pieces, chess_board, row + x, col + y)
    end
    p all_valid_moves
  end

  def pawn_valid_moves(opponent_pieces, row, col, chess_board, player_pieces)
    @all_valid_moves = []
    all_directions = [[-1, 0], [-1, -1], [-1, 1], [1, 0]]
    all_directions.each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
      if player_pieces.include?('♙')
        move_down(x, y, player_pieces, chess_board, ref_row, ref_col, opponent_pieces)
      elsif player_pieces.include?('♟')
        move_up(x, y, player_pieces, chess_board, ref_row, ref_col, opponent_pieces)
      end
    end
    @all_valid_moves
  end

  def move_down(x, y, player_pieces, chess_board, ref_row, ref_col, opponent_pieces)
    if ([x, y] == [1, 0]) && valid?(player_pieces, chess_board, ref_row, ref_col)
      @all_valid_moves << [ref_row, ref_col] if chess_board[ref_row][ref_col] == ' '
    elsif ([x, y] == [-1, -1] || [x, y] == [-1, 1]) && valid?(player_pieces, chess_board, ref_row, ref_col)
      @all_valid_moves << [ref_row, ref_col] if opponent_pieces.include?(chess_board[ref_row][ref_col])
    end
  end

  def move_up(x, y, player_pieces, chess_board, ref_row, ref_col, opponent_pieces)
    if [x, y] == [-1, 0] && valid?(player_pieces, chess_board, ref_row, ref_col)
      @all_valid_moves << [ref_row, ref_col] if chess_board[ref_row][ref_col] == ' '
    elsif ([x, y] == [-1, -1] || [x, y] == [-1, 1]) && valid?(player_pieces, chess_board, ref_row, ref_col)
      @all_valid_moves << [ref_row, ref_col] if opponent_pieces.include?(chess_board[ref_row][ref_col])
    end
  end

  def knight_valid_moves(row, col, chess_board, player_pieces)
    possible_moves = []
    [[-2, -1], [-2, 1], [2, -1], [2, 1], [1, -2], [-1, -2], [-1, 2], [1, 2]].each do |(x, y)|
      ref_row = row + x
      ref_col = col + y
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
    player_pieces.include?(chess_board[row][col]) == false # checks if next position to play is valid
  end
end
