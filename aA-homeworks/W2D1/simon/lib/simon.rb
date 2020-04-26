class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if !game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    system("clear")
    @seq.each_with_index do |color, idx|
      puts "#{idx + 1}: #{color}"
      sleep(1)
      system("clear")
    end
  end

  def require_sequence
    puts "enter the color sequence you saw"
    num = 0
    while num < @sequence_length
      print "#{num + 1}: "
      color = gets.chomp
      if color != @seq[num]
        @game_over = true
        break
      end
      num += 1
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "you got it!"
    puts "next round"
    sleep(1)
    system("clear")
  end

  def game_over_message
    puts "wrong!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
