require_relative "board"

class Minesweeper
  def initialize(difficulty)
    @board = Board.place_mine(difficulty)
  end

  def play_turn
    @board.render
    pos = get_pos
    action = get_action

    record_action(pos, action)
  end

  def run
    until game_over?
      play_turn
    end
  end

  def game_over?
    solved? || @board.any_bomb_revealed?
  end

  def solved?
    @board.solved?
  end

  def get_pos
  end

  def get_action
  end

  def record_action(pos, action)
  end

  def valid_pos?(pos)
  end

end