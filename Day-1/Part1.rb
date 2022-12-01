input = File.readlines("Day-1/input.txt", chomp: true)

highest_calories = 0
calorie_counter = 0
input.each do |calorie|
  if calorie.empty?
    if calorie_counter > highest_calories
      highest_calories = calorie_counter
    end
    calorie_counter = 0
  else
    calorie_counter += calorie.to_i
  end
end

puts highest_calories
