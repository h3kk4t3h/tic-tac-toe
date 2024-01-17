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
    if valid_move?(position)
      @board[position] = @current_player
      switch_player
    else
      raise "Invalid move: position #{position} is either out of bounds or already occupied"
    end
  end

  # Checks if a move is valid (i.e., within the board and not already occupied)
  def valid_move?(position)
    return false if position < 0 || position >= BOARD_SIZE
    return false if @board[position] != EMPTY_CELL
    true
  end

  # Switches the current player
  def switch_player
    @current_player = @current_player == PLAYER_X ? PLAYER_O : PLAYER_X
  end

  # Checks if the game is over (i.e., a player has won or the board is full)
  def game_over?
    win? || board_full?
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
