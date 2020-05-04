class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
    end
    puts game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    @sequence_length += 1 unless @game_over
    puts round_success_message unless @game_over
  end

  def show_sequence
    add_random_color
    @seq.each_with_index do |color, idx|
      system("clear")
      puts "#{idx + 1}: #{color}"
      sleep(1)
    end
  end

  def require_sequence
    system("clear")
    puts "enter your guess:" 
    i = 0
    while i < @sequence_length
      print "#{i + 1}: "
      input = gets.chomp

      if input != @seq[i]
        @game_over = true
        break
      end
      
      i += 1
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    "Good job! next round!"
  end

  def game_over_message
    "You lost."
  end

  def reset_game
    @seq = []
    @sequence_length = 1
    @game_over = false
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Simon.new
  g.play
end