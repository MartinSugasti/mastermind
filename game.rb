class Game
end

require_relative 'computer'
require_relative 'hittable'
require_relative 'codes'
require_relative 'output_effects'
require_relative 'player_maker'
require_relative 'player_breaker'
require_relative 'player_maker_game'
require_relative 'player_breaker_game'
require 'pry'

class Game
  include Hittable

  def initialize; end

  def play
    player = new_player
    player.is_a?(PlayerMaker) ? PlayerMakerGame.new(player).play : PlayerBreakerGame.new.play(player)
  end

  private

  def new_player
    puts "\nChoose your role:\n\n1 - Code maker\n\n2 - Code breaker\n\n"
    option = nil

    loop do
      option = gets.chomp.gsub(/\s+/, '')
      break if correct_option(option)

      puts "\nJust type 1 or 2:\n\n"
    end

    option == '1' ? PlayerMaker.new : PlayerBreaker.new
  end

  def correct_option(option)
    %w[1 2].include? option
  end

  def player_wins(string)
    puts "\nWhat a great #{string}! You got it.. #{'WIN!!!'.blink.bold.underline}\n\n\n"
  end

  def player_loses(string)
    puts "\nMaybe next time.. #{string}\n\n\n"
  end
end
