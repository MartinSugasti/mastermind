require_relative 'game'

class PlayerBreakerGame < Game
  def initialize
    super()
    @master_code = ComputerMaker.new.choose_master_code
    @round = 0

    print "\nComputer is choosing the master code."
    5.times do
      sleep(0.3)
      print '.'
    end
    puts ' Done! Now it\'s your time to break it!'
  end

  def play(player)
    guess_code = nil

    loop do
      @round += 1
      guess_code, hits = play_round(player)
      print_clues_messages(guess_code, hits)

      break if codes_equals?(guess_code, @master_code) || @round == 12
    end

    codes_equals?(guess_code, @master_code) ? player_wins : player_loses
  end

  private

  def play_round(player)
    code = player.guess_code(@round)
    hits = verify_hits(code, @master_code)

    [code, hits]
  end

  def player_wins
    puts "\nWhat a great strategy! You got it.. #{'WIN!!!'.blink.bold.underline}\n\n\n"
  end

  def player_loses
    master_code_message = @master_code.reduce('') { |result, number| "#{result}#{Codes.color(number)} " }
    puts "\nMaybe next time.. The code was #{master_code_message}\n\n\n"
  end
end
