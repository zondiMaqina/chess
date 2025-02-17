# frozen_string_loiteral: true
 
# class for setting chess piece
class Piece
  attr_reader :piece, :piece_name, :color
  def initialize
    @piece = '♗'
    @piece_name = 'bishop'
    @color = 'white'
  end
end
