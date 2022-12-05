input = File.readlines("Day-3/input.txt", chomp: true)

UPPERCASE_ASCII_OFFSET = 65

LOWERCASE_CODEPOINTS_OFFSET = 96

def find_priority(item)
  return uppercase?(item) ? item.ord - UPPERCASE_ASCII_OFFSET + 27 : item.ord - LOWERCASE_CODEPOINTS_OFFSET
end

def uppercase?(letter)
  return letter == letter.upcase
end

total_priority = 0

group_counter = 0
grouped_rucksacks = []

input.each do |line|
  group_counter += 1
  grouped_rucksacks.push(line.chars)
  if group_counter == 3
    common_item = (grouped_rucksacks[0] & grouped_rucksacks[1] & grouped_rucksacks[2])[0]
    total_priority += find_priority(common_item)
    group_counter = 0
    grouped_rucksacks.clear
  end
end

puts total_priority


