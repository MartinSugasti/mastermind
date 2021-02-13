require_relative 'dialog'
require_relative 'game'

puts Dialog.introduction

loop do
  Game.new.play
  puts Dialog.conclusion
  break unless gets.chomp.gsub(/\s+/, '').downcase == 'y'
end

puts 'Goodbye!'
