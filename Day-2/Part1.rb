def determine_outcome(opponent, player)
  case player
  when :X
    case opponent
    when :A
      return :tie
    when :B
      return :loss
    when :C
      return :win
    end
  when :Y
    case opponent
    when :A
      return :win
    when :B
      return :tie
    when :C
      return :loss
    end
  when :Z
    case opponent
    when :A
      return :loss
    when :B
      return :win
    when :C
      return :tie
    end
  end
end

input = File.readlines("input.txt", chomp: true)

shape_values = { A: 1, B: 2, C: 3, X: 1, Y: 2, Z: 3 }
outcome_values = { win: 6, tie: 3, loss: 0 }

shapes = input.map { |line| line.split.map(&:to_sym).map { |letter| new Shape(letter) } }
rounds = input.map { |line| line.split.map(&:to_sym) }

total_score = 0
rounds.each { |round| total_score += outcome_values[self.determine_outcome(round[0], round[1])] + shape_values[round[1]] }

puts total_score
