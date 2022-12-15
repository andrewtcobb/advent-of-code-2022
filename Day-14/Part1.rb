require 'set'

input = File.readlines("Day-14/input.txt", chomp: true)

rock_lines = []
input.each do |line|
  rock_line = line.delete(" \t\r\n").split('->').map { |coordinates| { x: coordinates.split(',').first.to_i, y: coordinates.split(',').last.to_i } }
  rock_lines.push(rock_line)
end

rock_coordinates = Set.new
deepest_rock_depth = 0

rock_lines.each do |rock_line|
  rock_line.each_with_index do |coordinate, i|
    unless i == rock_line.size - 1
      direction = (coordinate[:x] - rock_line[i + 1][:x]).abs > 0 ? :x : :y
      distance = (coordinate[direction] - rock_line[i + 1][direction]).abs
      positive = coordinate[direction] - rock_line[i + 1][direction] > 0 ? true : false

      distance.times do |j|
        if direction == :x
          x = positive ? coordinate[:x] - j : coordinate[:x] + j
          rock_coordinates.add({ x: x, y: coordinate[:y] })
        else
          y = positive ? coordinate[:y] - j : coordinate[:y] + j
          rock_coordinates.add(x: coordinate[:x], y: y)
          deepest_rock_depth = y if y > deepest_rock_depth
        end
      end
    else
      rock_coordinates.add(rock_line[i])
      deepest_rock_depth = rock_line[i][:y] if rock_line[i][:y] > deepest_rock_depth
    end
  end
end

sand_crosses_abyss_threshold = false
settled_sand = 0

until sand_crosses_abyss_threshold do
  settled = false
  sand_position = { x: 500, y: 0 }
  until settled do
    if !rock_coordinates.include?({ x: sand_position[:x], y: sand_position[:y] + 1 })
      sand_position = { x: sand_position[:x], y: sand_position[:y] + 1 }
    elsif !rock_coordinates.include?({ x: sand_position[:x] - 1, y: sand_position[:y] + 1 })
      sand_position = { x: sand_position[:x] - 1, y: sand_position[:y] + 1 }
    elsif !rock_coordinates.include?({ x: sand_position[:x] + 1, y: sand_position[:y] + 1 })
      sand_position = { x: sand_position[:x] + 1, y: sand_position[:y] + 1 }
    else
      settled = true
      settled_sand += 1
      rock_coordinates.add(sand_position)
    end
    if sand_position[:y] >= deepest_rock_depth
      sand_crosses_abyss_threshold = true
      break
    end
  end
end

puts settled_sand



