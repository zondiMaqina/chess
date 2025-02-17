# frozen_string_loiteral: true
 
# class for setting chess piece
class Piece
  attr_reader :color, :piece_name, :piece
  def initialize
    @piece = '♔'
    @color = 'white'
    @piece_name = 'knight'
  end
end