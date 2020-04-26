require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    ttt_node = TicTacToeNode.new(game.board, mark)
    tie_positions = []
    ttt_node.children.each do |child|
      return  child.prev_move_pos if child.winning_node?(mark)
      tie_positions << child.prev_move_pos if !child.losing_node?(mark)
    end 
    raise if tie_positions.empty?
    tie_positions.sample
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
