input = File.readlines("Day-1/input.txt", chomp: true)

calorie_counts = []
calorie_counter = 0
input.each do |calorie|
  if calorie.empty?
    calorie_counts.push(calorie_counter)
    calorie_counter = 0
  else
    calorie_counter += calorie.to_i
  end
end

puts calorie_counts.sort.last(3).sum
