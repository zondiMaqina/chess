# frozen_string_literal: true

# class for setting chess piece
class Piece
  attr_reader :color, :piece_name, :piece
  def initialize
    @piece = '♝'
    @color = 'white'
    @icon = ''
    @piece_name = 'pawn'
  end
end
