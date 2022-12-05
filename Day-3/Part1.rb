input = File.readlines("Day-3/input.txt", chomp: true)

UPPERCASE_ASCII_OFFSET = 65

LOWERCASE_CODEPOINTS_OFFSET = 96

def find_priority(item)
  return uppercase?(item) ? item.ord - UPPERCASE_ASCII_OFFSET + 27 : item.ord- LOWERCASE_CODEPOINTS_OFFSET
end

def uppercase?(letter)
  return letter == letter.upcase
end

total_priority = 0

input.each do |line|
  compartment1 = line[0..line.size / 2 - 1].chars
  compartment2 = line[line.size / 2..-1].chars

  common_item = (compartment1 & compartment2)[0]

  total_priority += find_priority(common_item)
end

puts total_priority


