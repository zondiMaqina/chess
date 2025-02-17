# frozen_string_literal: true

# class for setting chess piece
class Piece
  attr_reader :piece, :piece_name, :color
  def initialize
    @piece = '♛'
    @piece_name = 'queen'
    @color = 'black'
  end
end
