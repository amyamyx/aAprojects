require_relative "player"


class HumanPlayer < Player
  def initialize(color, display)
    super(color, display)
  end
  
  def make_move(board)
    begin
      pos_1, pos_2 = nil, nil
      
      loop do
        pos_1 = @display.cursor.get_input
        @display.render
        break if !pos_1.nil?
      end

      loop do
        pos_2 = @display.cursor.get_input
        @display.render
        break if !pos_2.nil?
      end

      board.move_piece(pos_1, pos_2)
    rescue => e
      puts e.message
      retry
    end

    true
  end
end