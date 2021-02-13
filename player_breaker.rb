require_relative 'player'

class PlayerBreaker < Player
  def guess_code(round)
    puts "\n##{round}: Choose your guess code:\n\n"
    code = nil

    loop do
      correct_code, code = verify_code

      break if correct_code
    end

    code
  end
end
