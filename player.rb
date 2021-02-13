require_relative 'codes'

class Player
  def initialize; end

  def self.new_player
    puts "\nChoose your role:\n\n1 - Code maker\n\n2 - Code breaker\n\n"
    option = nil

    loop do
      option = gets.chomp.gsub(/\s+/, '')
      break if correct_option(option)

      puts "\nJust type 1 or 2:\n\n"
    end

    option == '1' ? PlayerMaker.new : PlayerBreaker.new
  end

  def self.correct_option(option)
    %w[1 2].include? option
  end

  private

  def verify_code
    code = gets.chomp.gsub(/\s+/, '').split('')
    correct_code = check_code(code)

    [correct_code, code]
  end

  def check_code(code)
    if (code - Codes::CODE_OPTIONS).any?
      puts "\nCode must consist of numbers between 1 and 6:\n\n"
      false
    elsif code.length != Codes::CODE_LENGTH
      puts "\nJust take #{Codes::CODE_LENGTH} numbers:\n\n"
      false
    else
      true
    end
  end
end
