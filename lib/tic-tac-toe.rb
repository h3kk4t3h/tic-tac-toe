class Game
  PLAYER_X = 'X'
  PLAYER_O = 'O'
  EMPTY_CELL = '-'
  BOARD_SIZE = 9
  LINES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize
    @board = Array.new(BOARD_SIZE, EMPTY_CELL)
    @current_player = PLAYER_X
  end

  # Prints the current state of the board
  def print_board
    @board.each_slice(3).with_index do |row, i|
      puts "#{i}  #{row.join(' | ')}"
      puts "  ---+---+---" unless i == 2
    end
  end

  # Makes a move for the current player at the given position
  def make_move(position)
    raise "Invalid move: position #{position} is either out of bounds or already occupied" unless valid_move?(position)
    @board[position] = @current_player
    switch_player unless game_over?
  end

  # Checks if a move is valid
  def valid_move?(position)
    return false if position < 0 || position >= BOARD_SIZE
    return false if @board[position] != EMPTY_CELL
    true
  end

  # Switches the current player
  def switch_player
    @current_player = @current_player == PLAYER_X ? PLAYER_O : PLAYER_X
  end

  # Checks if the game is over (
  def game_over?
    return switch_player if win?
    return 'Draw' if board_full?
    nil
  end

 # Controls the flow of the game
def play
  result = nil
  until result
    begin
      puts "\n\n"
      print_board
      puts "\nCurrent player: #{@current_player}"
      print "Enter a position: "
      position = gets.chomp.to_i
      make_move(position)
      result = game_over?
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end
  switch_player if result != 'Draw'  # Switch back to the winner
  print_board
  puts "\nGame Over!"
  puts "\n"
  puts "Winner: Player #{result}" unless result == 'Draw'
  puts "It's a draw!" if result == 'Draw'
end

  private

  # Checks if a player has won the game
  def win?
    LINES.any? do |line|
      @board.values_at(*line).uniq.length == 1 && @board[line[0]] != EMPTY_CELL
    end
  end

  # Checks if the board is full
  def board_full?
    @board.none?(EMPTY_CELL)
  end
end

system "clear" or system "cls"  # Clear the terminal
puts "Welcome player!"
Game.new.play
