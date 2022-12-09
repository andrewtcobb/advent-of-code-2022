require 'set'

def tail_too_far_away_from_head?(head_position, tail_position)
  return true if (head_position[:x] - tail_position[:x]).abs > 1
  return true if (head_position[:y] - tail_position[:y]).abs > 1
  return false
end

input = File.readlines("Day-9/input.txt", chomp: true)

tail_positions = Set[x:0, y:0]
current_head_position = { x: 0, y: 0 }
current_tail_position = { x: 0, y: 0 }

input.each do |line|
  direction, distance = line.split(' ')

  distance.to_i.times do
    new_head_position = current_head_position.dup
    case direction
    when "R"
      new_head_position[:x] += 1
    when "L"
      new_head_position[:x] -= 1
    when "U"
      new_head_position[:y] += 1
    when "D"
      new_head_position[:y] -= 1
    end
    if tail_too_far_away_from_head?(new_head_position, current_tail_position)
      current_tail_position = current_head_position
      tail_positions.add(current_tail_position)
    end
    current_head_position = new_head_position
  end
end

puts tail_positions.size