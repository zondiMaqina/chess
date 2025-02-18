# frozen_string_literal: true


# class for storing both players' pieces
class PlayersPieces
  def initialize
    @black_pieces = [%w[♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟], %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜]]
    @white_pieces = [%w[♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙], %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖]]
    @identifiers = {pawn: %w[♟ ♙], rook: %w[♜ ♖], knight: %w[♞ ♘], bishop: %w[♝ ♗], queen: %w[♛ ♕], king: %w[♚ ♔]}
  end
end
