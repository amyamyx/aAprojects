require_relative "board"

class Minesweeper

    DIFFICULTIES = {
    beginner: {dimention: [10,10], num_mines: 10},
    intermediate: { dimention: [16, 16], num_mines: 40 },
    expert: { dimention: [16, 30], num_mines: 99 }
  }

  def initialize(difficulty)
    @board = Board.new(DIFFICULTIES[difficulty])
  end

  def run
    @board.place_mines
    
    until game_over?
      play_turn
    end
    display_board
  end
  
  private

  def play_turn
    display_board

    pos = get_pos
    action = get_action

    if invalid_action?(pos, action)
      inform_invalid_action(pos, action) 
    else
      record_action(pos, action)
    end
  end

  def display_board
    system("clear")
    @board.render
  end

  def game_over?
    solved? || lost?
  end

  def solved?
    @board.solved?
  end

  def lost?
    @board.any_bomb_revealed?
  end
  
  def get_pos
    pos = nil

    until pos && valid_pos?(pos)
      puts "please enter a position. Ex. '3,4' > "

      begin
        pos = parse_pos(gets.chomp)
        valid_pos?(pos)
      rescue
        puts "Did you type a comma to separate the numbers? Try again"
        pos = nil
      end

    end

    pos
  end

  def parse_pos(str)
    str.split(",").map { |i| Integer(i) }
  end

  def get_action
    action = nil

    until [1, 2].include?(action)
      puts "please enter 1 or 2" if !action.nil?
      puts "Enter '1' to place or remove a flag"
      puts "Enter '2' to reveal a tile"
      print "What do you want to do > "
      action = gets.chomp[0].to_i
    end

    action
  end

  def record_action(pos, action)
    action == 1 ? @board[pos].toggle_flag : @board.reveal(pos)
  end

  def valid_pos?(pos)
    pos.length == 2 && @board.valid_pos?(pos)
  end

  def invalid_action?(pos, action)
    @board[pos].revealed || 
      (action == 2 && @board[pos].flagged)
  end

  def inform_invalid_action(pos, action)
    puts "You can't flag a revealed tile." if action == 1 && @board[pos].revealed
    puts "It's been revealed." if action == 2 && @board[pos].revealed
    puts "You can't reveal a flag!" if action == 2 && @board[pos].flagged
  end

end