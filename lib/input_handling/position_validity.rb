# frozen_string_literal: true

require_relative './input_validity'

# class for handling positions on board requested by players
class PositionValidity < InputValidity
  def initialize
    super
    @rows = %w[A B C D E F G H]
  end

  def board_position_valid?(chess_board, position, player_pieces)
    
  end

  def position_yours?(chess_board, position, player_pieces)
    row = @rows.index(position[0].upcase)
    col = position[1].to_i
    pos_selected = chess_board[row][col]
    player_pieces.include?(pos_selected)
  end

  def try_again(chess_board, position, player_pieces)
    until position_valid?(chess_board, position, player_pieces) && input_valid?(position)
      puts 'position empty or piece is unmoveable try again'
      position = gets.chomp
    end
    position
  end

  def position_valid?(chess_board, position, player_pieces)
    position_yours?(chess_board, position, player_pieces) && piece_moveable?(chess_board, position)
  end

  def piece_moveable?(chess_board, position)
    
  end
end

# test if input for selecting piece:
# does not lead to empty position in board
# does not lead to opponent's piece
# does not lead to piece that cannot move
