# frozen_string_literal: true


# class for both players' pieces
class PlayersPieces
  def initialize
    @black_pieces = [%w[♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟], %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜]]
    @white_pieces = [%w[♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙], %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖]]
  end
end
