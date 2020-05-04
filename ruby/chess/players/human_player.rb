require_relative "player"

class HumanPlayer < Player
  def initialize(color, display)
    super(color, display)
    @cursor = display.cursor
  end

  def make_move(_board)
    cursor = @display.cursor

    start_pos = get_pos
    selected_piece = _board[start_pos]
    selected_piece.toggle_selected
    end_pos = get_pos
    
    _board.move_piece!(start_pos, end_pos)
    selected_piece.toggle_selected

  end

  def get_pos
    system("clear")
    @display.render
    pos = @cursor.get_input
    while pos.nil?
      system("clear")
      @display.render
      pos = @cursor.get_input 
    end
    pos
  end
end