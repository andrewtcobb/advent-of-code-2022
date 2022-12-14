require 'json'

input = File.readlines("Day-13/input.txt", chomp: true)

def packet_pair_in_right_order?(packet_pair)
  packet1 = packet_pair[0]
  packet2 = packet_pair[1]

  return true if packet1.empty? && !packet2.empty?
  return false if !packet1.empty? && packet2.empty?

  packet1.each_with_index do |left_value, index|
    right_value = packet2[index]

    if left_value.kind_of?(Numeric) && right_value.kind_of?(Numeric)
      return true if left_value < right_value
      return false if left_value > right_value
    else
      values_to_compare = []
      if left_value.kind_of?(Array) && right_value.kind_of?(Array)
        values_to_compare = [left_value, right_value]
      else
        if left_value.kind_of?(Numeric)
          values_to_compare = [[left_value], right_value]
        else
          values_to_compare = [left_value, [right_value]]
        end
      end
      in_order = packet_pair_in_right_order?(values_to_compare)
      return true if in_order == true
      return false if in_order == false
    end

    return true if packet1.size - 1 == index && packet2.size - 1 > index
    return false if packet1.size - 1 > index && packet2.size - 1 == index
    unless packet1.size - 1 == index && packet2.size - 1 == index
      next
    end
  end

  return nil
end

packet_pairs = []

input.each_with_index do |line, index|
  if index % 3 == 0
    packet_1 = JSON.parse(line)
    packet_2 = JSON.parse(input[index + 1])
    packet_pairs.push([packet_1, packet_2])
  end
end

sum_of_packet_pair_indexes_in_right_order = 0
packet_pairs.each_with_index do |packet_pair, index|
  if packet_pair_in_right_order?(packet_pair)
    sum_of_packet_pair_indexes_in_right_order += index + 1
  end
end

puts sum_of_packet_pair_indexes_in_right_order


