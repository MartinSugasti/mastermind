require_relative 'computer'
require_relative 'hittable'

class ComputerBreaker < Computer
  MAX_FIXNUM =  (2**(0.size * 8 - 2) - 1)

  include Hittable

  def initialize
    super()
    @untried_codes = (1111..6666).to_a.map(&:to_s).select do |value|
      value.count('0789').zero?
    end
    @possible_codes = @untried_codes
    @next_code_to_try = '1122'
  end

  def guess_code(round)
    puts "\n##{round}: Computer tried with the next code:\n\n"

    @untried_codes.delete(@next_code_to_try).split('')
  end

  def compute_possible_solutions(code, hits)
    remove_impossible_codes(code, hits)
    next_guess_by_minmax
  end

  private

  def remove_impossible_codes(code, hits)
    @possible_codes.select! do |possible_code|
      hits == verify_hits(code, possible_code.split(''))
    end
  end

  def next_guess_by_minmax
    score = MAX_FIXNUM

    @untried_codes.each do |guess_code|
      possible_scores = {}

      @possible_codes.each do |possible_master|
        hits = verify_hits(guess_code.split(''), possible_master.split(''))
        possible_scores[hits] = possible_scores[hits].to_i + 1
      end

      if possible_scores.values.max < score
        score = possible_scores.values.max
        @next_code_to_try = guess_code
      end
    end
  end
end
