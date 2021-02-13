require_relative 'game'
require_relative 'computer_breaker'
require_relative 'output_effects'

class PlayerMakerGame < Game
  def initialize(player)
    super()
    @master_code = player.choose_master_code
    @round = 0
    @computer = ComputerBreaker.new
  end

  def play
    guess_code = nil

    loop do
      @round += 1
      guess_code, hits = play_round(@computer)
      print_clues_messages(guess_code, hits)

      break if codes_equals?(guess_code, @master_code) || @round == 12
    end

    codes_equals?(guess_code, @master_code) ? player_loses : player_wins('master code')
  end

  private

  def play_round(computer)
    sleep(3)
    code = computer.guess_code(@round)
    hits = verify_hits(code, @master_code)
    computer.compute_possible_solutions(code, hits)

    [code, hits]
  end

  def player_loses
    super("Your code was #{'BROKEN!'.bold.underline.blink}")
  end
end
