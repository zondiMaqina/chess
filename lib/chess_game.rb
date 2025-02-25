# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'input_handling/position_validity'
require_relative 'chess_pieces/players_pieces'
require_relative 'chess_pieces/input_convertion'

# class for running chess game
class ChessGame < PositionValidity
  attr_reader :white_pieces, :black_pieces, :board, :piece_selection, :chess_board

  def initialize
    super
    @board = Board.new
    @chess_board = board.chess_board
    @white_pieces = @board.pieces.white_pieces
    @black_pieces = @board.pieces.black_pieces
    @piece_selection = PieceSelection.new
  end

  def verify_moves(position, opponent_pieces, player_pieces)
    pos = [rows.index(position[0]), position[1].to_i]
    moves = piece_selection.find_valid_moves(opponent_pieces, pos, chess_board, player_pieces)
    piece_name = piece_selection.piece_name
    return choose_destination(piece_name, position) unless moves.empty?

    try_again(chess_board, position, player_pieces, opponent_pieces)
  end

  def choose_destination(piece_name, position)
    puts "you have chosen a #{piece_name} at #{position}"
  end
end
