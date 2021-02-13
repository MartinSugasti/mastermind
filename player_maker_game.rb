require_relative 'game'

class PlayerMakerGame < Game
  def initialize(player)
    super()
    @master_code = player.choose_master_code
  end

  def play

  end
end
