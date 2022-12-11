require 'set'

input = File.readlines("Day-10/input.txt", chomp: true)

def observe_cycle?(cycle)
  cycles_to_observe = Set[20, 60, 100, 140, 180, 220]
  return cycles_to_observe.include? cycle
end

register = 1
cycle_number = 0
signal_strengths = Array.new
CYCLE_TIME_FOR_ADDING = 2


input.each_with_index do |instruction|
  if instruction == 'noop'
    cycle_number += 1
    if observe_cycle?(cycle_number)
      signal_strengths.push(cycle_number * register)
    end
  else
    value = instruction.split(' ').last.to_i

    CYCLE_TIME_FOR_ADDING.times do
      cycle_number += 1
      if observe_cycle?(cycle_number)
        signal_strengths.push(cycle_number * register)
      end
    end

    register += value
  end
end

puts signal_strengths.sum