require_relative 'player'

class PlayerMaker < Player
  def choose_master_code
    puts "\nChoose the master code. Make sure it\'s a tought one:\n\n"
    code = nil

    loop do
      correct_code, code = verify_code

      break if correct_code
    end

    puts "\nThat\'s a wise master code..\n"
    code
  end
end
