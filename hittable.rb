module Hittable
  def verify_hits(code, master)
    code = Marshal.load(Marshal.dump(code))
    master = Marshal.load(Marshal.dump(master))
    hits, code_without_exacts, master_without_exacts = verify_exact_hits(code, master)
    verify_color_hits(hits, code_without_exacts, master_without_exacts)
  end

  def verify_exact_hits(code, master)
    hits = []
    exact_indexes = []

    code.each_with_index do |number, index|
      if number == master[index]
        hits << Codes.full_circle
        exact_indexes << index
      end
    end

    [hits, remove_indexes(code, exact_indexes), remove_indexes(master, exact_indexes)]
  end

  def remove_indexes(array, indexes)
    array.reject.with_index { |_, index| indexes.include? index }
  end

  def verify_color_hits(hits, code_without_exacts, master_without_exacts)
    code_without_exacts.each do |number|
      if master_without_exacts.include? number
        hits << Codes.empty_circle
        master_without_exacts.delete_at(master_without_exacts.find_index(number))
      end
    end

    hits
  end

  def print_clues_messages(code, clues)
    code_message = code.map { |number| "#{Codes.color(number)} " }
    code_message << ['  Clues: ', printable_clues(clues), "\n\n"]

    printable_message = code_message.flatten.reduce('') do |result, current|
      result + current
    end

    puts "\n#{printable_message}"
  end

  def printable_clues(clues)
    clues.map do |clue|
      "#{clue} "
    end
  end

  def codes_equals?(first_code, second_code)
    first_code == second_code
  end
end
