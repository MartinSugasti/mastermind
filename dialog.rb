require_relative 'codes'
require_relative 'output_effects'

module Dialog
  def self.introduction
    <<~INTRODOC


                                  #{'MASTERMIND!!!'.blink.bold.underline}


      Welcome! Here are the rules:

      - There is a code maker and a code breaker.

      - The code maker will choose a combination, where order matters, of 4 from 6 six colors. This would be the master code.

      #{Codes.color('1')} #{Codes.color('2')} #{Codes.color('3')} #{Codes.color('4')} #{Codes.color('5')} #{Codes.color('6')}

      - The master code could repeat colors.

      - The code breaker will try to guess the master code in 12 turns at most.

      - For each guess that the code breaker does, the code maker will tell him/her up to four clues according to the next norms:

        #{Codes.full_circle} This clue means the guesses code has 1 correct number in the correct location.

        #{Codes.empty_circle} This clue means the guesses code has 1 correct number, but in the wrong location.

      - If there are duplicate colors in the guess, they cannot all be awarded with a #{Codes.full_circle} unless they correspond to the same number of duplicate colors in the master code. For example, if the master code is

        #{Codes.color('1')} #{Codes.color('1')} #{Codes.color('2')} #{Codes.color('2')}

      and the player guesses

        #{Codes.color('1')} #{Codes.color('1')} #{Codes.color('1')} #{Codes.color('2')}

      the code maker clues will be two #{Codes.full_circle} #{Codes.full_circle} for the two correct reds, nothing for the third red as there is not a third red in the code, and another #{Codes.full_circle} for the blue. No  indication is given of the fact that the code also includes a second blue.


      For last, let's make an example to get down all that was said:

      Suposse the code maker choose the next master code:

        #{Codes.color('1')} #{Codes.color('2')} #{Codes.color('5')} #{Codes.color('1')}

      and the code breaker guesses the code:

        #{Codes.color('1')} #{Codes.color('5')} #{Codes.color('6')} #{Codes.color('2')}

      the clues will be:

        #{Codes.full_circle} #{Codes.empty_circle} #{Codes.empty_circle}

      The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location.


      All that said.. it's time to play!

    INTRODOC
  end

  def self.conclusion
    "What a nice game. Type \'y\' and go for the revange or any key to quit.\n\n"
  end
end
