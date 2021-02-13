class Computer
  def initialize; end
end

class ComputerMaker < Computer
  def choose_master_code
    (1..4).map { rand(1..6).to_s }
  end
end

class ComputerBreaker < Computer
  def choose_guess_code
    # poner logica de https://stackoverflow.com/questions/62430071/donald-knuth-algorithm-mastermind
  end
end
