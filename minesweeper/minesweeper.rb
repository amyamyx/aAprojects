require_relative "board"

class Minesweeper

  DIFFICULTIES = {
    beginner: {
      dimention: [10, 10],
      num_mines: 10
    },
    intermediate: { 
      dimention: [16, 16], 
      num_mines: 40 
    },
    expert: { 
      dimention: [16, 30], 
      num_mines: 99 
    }
  }

  def initialize(difficulty)
    @board = Board.new(DIFFICULTIES[difficulty])
  end

  def run
    @board.place_mines 
    play_turn until game_over?
    flag_remaining_bombs if solved?
    display_board
  end
  
  private

  def play_turn
    display_board

    pos = get_pos
    action = get_action

    act_upon(pos, action)
  end

  def act_upon(*pos_action)
    if invalid_action?(*pos_action)
      inform_invalid_action(*pos_action)
    else
      record_action(*pos_action)
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
    @board.any_triggered_bomb?
  end
  
  def get_pos
    pos = nil

    until pos && valid_pos?(pos)
      display_invalid_pos_message if !pos.nil?
      print "please enter a position. Ex. '3,4' > "

      begin
        pos = parse_pos(gets.chomp)
      rescue
        display_invalid_pos_message
        pos = nil
      end
    end

    pos
  end

  def parse_pos(str)
    str.split(",").map { |i| Integer(i) }
  end

  def display_invalid_pos_message
    puts "Did you type a comma to separate the numbers? Try again" 
  end

  def get_action
    action = nil

    until [1, 2].include?(action)
      puts "please enter 1 or 2" if !action.nil?
      print "Enter '1' to place or remove a flag, '2' to reveal a tile >"
      action = gets.chomp[0].to_i
    end

    action
  end

  def record_action(pos, action)
    action == 1 ? @board.toggle_flag(pos) : @board.reveal(pos)
  end

  def valid_pos?(pos)
    pos.length == 2 && @board.valid_pos?(pos)
  end

  def invalid_action?(pos, action)
    revealed_tile?(pos)|| revealing_flag?(pos, action) 
  end

  def revealed_tile?(pos)
    @board[pos].revealed
  end

  def revealing_flag?(pos, action)
    action == 2 && @board[pos].flagged
  end

  def inform_invalid_action(pos, action)
    puts "You can't flag a revealed tile." if action == 1 && revealed_tile?(pos)
    puts "It's been revealed." if action == 2 && revealed_tile?(pos)
    puts "You can't reveal a flag!" if revealing_flag?(pos, action)
  end

  def flag_remaining_bombs
    @board.flag_all_bombs
  end
end