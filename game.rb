require_relative 'codes'
require_relative 'player'
require_relative 'computer'
require_relative 'output_effects'
require 'pry'

class Game
  def initialize; end

  def play
    player = Player.new_player
    player.is_a?(PlayerMaker) ? PlayerMakerGame.new(player).play : PlayerBreakerGame.new.play(player)
  end

  private

  def verify_hits(code, master)
    code = Marshal.load(Marshal.dump(code))
    master = Marshal.load(Marshal.dump(master))
    hits, code_without_exacts, master_without_exacts = verify_exact_hits(code, master)
    verify_color_hits(hits, code_without_exacts, master_without_exacts)
  end

  def verify_exact_hits(code, master)
    hits = []
    exact_indexes = []

    code.each_with_index do |number, index|
      if number == master[index]
        hits << Codes.full_circle
        exact_indexes << index
      end
    end

    [hits, remove_indexes(code, exact_indexes), remove_indexes(master, exact_indexes)]
  end

  def remove_indexes(array, indexes)
    array.reject.with_index { |_, index| indexes.include? index }
  end

  def verify_color_hits(hits, code_without_exacts, master_without_exacts)
    code_without_exacts.each do |number|
      if master_without_exacts.include? number
        hits << Codes.empty_circle
        master_without_exacts.delete_at(master_without_exacts.find_index(number))
      end
    end

    hits
  end

  def print_clues_messages(code, clues)
    code_message = code.map { |number| "#{Codes.color(number)} " }
    code_message << ['  Clues: ', printable_clues(clues), "\n\n"]

    printable_message = code_message.flatten.reduce('') do |result, current|
      result + current
    end

    puts "\n#{printable_message}"
  end

  def printable_clues(clues)
    clues.map do |clue|
      "#{clue} "
    end
  end

  def codes_equals?(first_code, second_code)
    first_code.sort == second_code.sort
  end
end

class PlayerMakerGame < Game
  def initialize(player)
    super()
    @master_code = player.choose_master_code
  end

  def play

  end
end

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

