# frozen_string_literal: true

# class for storing both players' pieces
class PlayersPieces
  attr_reader :black_pieces, :white_pieces, :identifiers

  def initialize
    @white_pieces = [%w[♟ ♟ ♟ ♟ ♟ ♟ ♟ ♟], %w[♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜]]
    @black_pieces = [%w[♙ ♙ ♙ ♙ ♙ ♙ ♙ ♙], %w[♖ ♘ ♗ ♕ ♔ ♗ ♘ ♖]]
    @identifiers = {pawn: %w[♟ ♙], rook: %w[♜ ♖], knight: %w[♞ ♘], bishop: %w[♝ ♗], queen: %w[♛ ♕], king: %w[♚ ♔]}
  end
end
