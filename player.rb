require_relative 'codes'

class Player
  def initialize; end

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
