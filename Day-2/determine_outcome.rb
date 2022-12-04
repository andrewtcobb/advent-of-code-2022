module DetermineOutcome
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
end
