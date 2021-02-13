require_relative 'computer'

class ComputerMaker < Computer
  def choose_master_code
    (1..4).map { rand(1..6).to_s }
  end
end
