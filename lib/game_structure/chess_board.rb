# frozen_string_literal: true

require_relative '../chess_pieces/players_pieces'
require 'terminal-table'

# class for dispalying chess board
class Board
  attr_reader :chess_board, :pieces
  def initialize
    @pieces = PlayersPieces.new
    @chess_board = Array.new(8) { Array.new(8, ' ')} # literal chess board
    @columns = %w[+ 0 1 2 3 4 5 6 7]
    @rows = %w[a b c d e f g h]
  end

  def set_pieces # sets the positions of pieces on chess board
    set_black_pieces
    set_white_pieces
    print_chess_board
  end

  def set_black_pieces
    chess_board[0] = pieces.black_pieces[1]
    chess_board[1] = pieces.black_pieces[0]
  end

  def set_white_pieces
    chess_board[-1] = pieces.white_pieces[1]
    chess_board[-2] = pieces.white_pieces[0]
  end

  def print_chess_board
    board = Terminal::Table.new do |table|
      table.add_row @columns
      table.add_separator
      chess_board.each_with_index do |row, index|
        table.add_row [@rows[index], row].flatten
        table.add_separator if index < 7
      end
    end
    puts board
  end
end
