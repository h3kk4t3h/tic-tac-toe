# frozen_string_literal: true

# This is the main game class
class Game
  PLAYER_X = 'X'
  PLAYER_O = 'O'
  EMPTY_CELL = '-'
  BOARD_SIZE = 9
  LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  def initialize
    @board = Array.new(BOARD_SIZE, EMPTY_CELL)
    @current_player = PLAYER_X
  end

  def print_board
    @board.each_slice(3).with_index do |row, i|
      puts "#{i}  #{row.join(' | ')}"
      puts '  ---+---+---' unless i == 2
    end
  end

  def make_move(position)
    raise "Invalid move: position #{position} is either out of bounds or already occupied" unless valid_move?(position)

    @board[position] = @current_player
  end

  def valid_move?(position)
    return false if position.negative? || position >= BOARD_SIZE
    return false if @board[position] != EMPTY_CELL

    true
  end

  def switch_player
    @current_player = @current_player == PLAYER_X ? PLAYER_O : PLAYER_X
  end

  def game_over?
    return @current_player == PLAYER_X ? PLAYER_O : PLAYER_X if win?
    return 'Draw' if board_full?

    nil
  end

  def play
    result = play_turn until result
    end_game(result)
  end

  def play_turn
    begin
      display_turn_info
      position = get_position
      make_move(position)
      result = game_over?
      switch_player unless result
    rescue RuntimeError => e
      puts e.message
      retry
    end
    result
  end

  def display_turn_info
    puts "\n\n"
    print_board
    puts "\nCurrent player: #{@current_player}"
  end

  def get_position
    print 'Enter a position: '
    gets.chomp.to_i
  end

  def end_game(result)
    print_board
    puts "\nGame Over!"
    puts "\n"
    puts "Winner: Player #{result}" unless result == 'Draw'
    puts "It's a draw!" if result == 'Draw'
  end

  private

  def win?
    LINES.any? do |line|
      @board.values_at(*line).uniq.length == 1 && @board[line[0]] != EMPTY_CELL
    end
  end

  def board_full?
    @board.none?(EMPTY_CELL)
  end
end

# Uncomment to play
# system 'clear' or system 'cls'  # Clear the terminal
# puts 'Welcome player!'
# Game.new.play
