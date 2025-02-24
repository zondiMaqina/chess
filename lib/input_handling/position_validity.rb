# frozen_string_literal: true

require_relative 'input_validity'
require_relative '../chess_pieces/input_convertion'
# class for handling positions on board requested by players
class PositionValidity < InputValidity
  attr_reader :rows, :piece_selection

  def initialize
    super
    @rows = %w[a b c d e f g h]
    @piece_selection = PieceSelection.new
  end

  def position_yours?(chess_board, position, player_pieces)
    row = position[0]
    col = position[1]
    pos_selected = chess_board[row][col]
    player_pieces.include?(pos_selected)
  end

  def try_again(chess_board, position, player_pieces, opp_pieces)
    until position_valid?(chess_board, position, player_pieces, opp_pieces) && input_valid?(position)
      puts 'position not yours or piece is unmoveable try again'
      position = gets.chomp
    end
    position
  end

  def position_valid?(chess_board, position, player_pieces, opp_pieces)
    position_yours?(chess_board, position, player_pieces) && moveable?(chess_board, position, player_pieces, opp_pieces)
  end

  def moveable?(chess_board, position, player_pieces, opponent_pieces)
    moves = piece_selection.find_valid_moves(opponent_pieces, position, chess_board, player_pieces)
    moves.empty? == false
  end
end

# test if input for selecting piece:
# does not lead to empty position in board
# does not lead to opponent's piece
# does not lead to piece that cannot move
