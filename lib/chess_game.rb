# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'input_handling/position_validity'
require_relative 'chess_pieces/players_pieces'
require_relative 'chess_pieces/input_convertion'

require 'colorize'

# class for running chess game
class ChessGame < PositionValidity
  attr_reader :player1_pieces, :player2_pieces, :board, :piece_selection, :chess_board

  def initialize
    super
    @board = Board.new
    @chess_board = board.chess_board
    @piece_selection = PieceSelection.new
    @player1_pieces = %w[♜ ♞ ♝ ♛ ♚ ♟ ♔]
    @player2_pieces = %w[♖ ♘ ♗ ♕ ♔ ♙ ♚]
  end

  def game_introduction
    prepare_chess_board
    puts <<-HEREDOC
      TERMINAL BASED CHESS
      -----------------------
      Welcome to Chess !!!
      You get to choose to play against your opponent
      #{board.print_chess_board}
      Player One -> [white pieces]
      Player Two -> [black pieces]
    HEREDOC
  end

  def prepare_chess_board
    board.set_pieces
  end

  def play_player1
    puts 'Select piece to move player 1'.colorize(:blue)
    verify_input(gets.chomp, chess_board, player1_pieces, player2_pieces)
  end

  def play_player2
    puts 'Select piece player 2'.colorize(:blue)
    verify_input(gets.chomp, chess_board, player2_pieces, player1_pieces)
  end

  def start_game
    game_introduction
    loop do
      play_player1
      play_player2
    end
  end

  def verify_input(player_input, chess_board, player_pieces, opp_pieces)
    return verify_validity(player_input, chess_board, player_pieces, opp_pieces) if input_valid?(player_input)

    player_input = try_again(chess_board, player_input, player_pieces[0..5], opp_pieces)
    verify_validity(player_input, chess_board, player_pieces, opp_pieces)
  end

  def verify_validity(position, chess_board, player_pieces, opp_pieces)
    return verify_moves(position, opp_pieces, player_pieces) if position_valid?(chess_board, position, player_pieces,
                                                                                opp_pieces)

    position = try_again(chess_board, position, player_pieces[0..5], opp_pieces)
    verify_moves(position, opp_pieces, player_pieces)
  end

  def verify_moves(position, opponent_pieces, player_pieces)
    position = [rows.index(position[0].downcase), position[1].to_i]
    @moves = piece_selection.find_valid_moves(opponent_pieces, position, chess_board, player_pieces)
    piece_name = piece_selection.piece_name
    return choose_destination(piece_name, position) unless @moves.empty?

    puts 'haibo'
    move = try_again(chess_board, position, player_pieces[0..5], opponent_pieces)
    piece_name = piece_selection.convert_position(chess_board[@rows.index(move[0]), move[1].to_i])
    @moves = piece_selection.find_valid_moves(opponent_pieces, move, chess_board, player_pieces)
    position = [rows.index(move[0].downcase), move[1].to_i]
    choose_destination(piece_name, position)
  end

  def choose_destination(piece_name, position)
    puts "you have chosen a #{piece_name} at #{rows[position[0]]}#{position[1]}".colorize(:green)
    puts 'select destination'
    pos2 = gets.chomp
    return move_piece(position, pos2) if input_valid?(pos2) && @moves.include?([rows.index(pos2[0]), pos2[1].to_i])

    pos2 = select_destination(pos2)
    move_piece(position, pos2)
  end

  def move_piece(old_pos, new_pos)
    p old_pos, new_pos
    piece = chess_board[old_pos[0]][old_pos[1]]
    chess_board[old_pos[0]][old_pos[1]] = ' '
    chess_board[rows.index(new_pos[0])][new_pos[1].to_i] = piece
    board.print_chess_board
  end

  def select_destination(pos2)
    until input_valid?(pos2) && @moves.include?([rows.index(pos2[0]), pos2[1].to_i])
      puts 'position not valid'.colorize(:red)
      pos2 = gets.chomp
    end
    pos2
  end
end

ChessGame.new.start_game
