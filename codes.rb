module Codes
  CODE_OPTIONS = %w[1 2 3 4 5 6].freeze
  CODE_LENGTH = 4

  # colors
  def self.color(number)
    {
      '1' => "\e[41m  1  \e[0m",
      '2' => "\e[44m  2  \e[0m",
      '3' => "\e[43m  3  \e[0m",
      '4' => "\e[45m  4  \e[0m",
      '5' => "\e[42m  5  \e[0m",
      '6' => "\e[46m  6  \e[0m"
    }[number]
  end

  # clues
  def self.full_circle
    "\u25CF"
  end

  def self.empty_circle
    "\u25CB"
  end
end
