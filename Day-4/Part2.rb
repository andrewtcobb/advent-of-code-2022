input = File.readlines("Day-4/input.txt", chomp: true)

def groupA_contains_section_from_groupB?(groupA, groupB)
  return (groupA[:begin] >= groupB[:begin] && groupA[:begin] <= groupB[:end]) || (groupA[:end] >= groupB[:begin] && groupA[:end] <= groupB[:end])
end

paired_groups = input.map do |line|
  assignment1, assignment2 = line.split(',')
  assignment1_begin, assignment1_end = assignment1.split('-')
  assignment2_begin, assignment2_end = assignment2.split('-')

  [{ begin: assignment1_begin.to_i, end: assignment1_end.to_i }, { begin: assignment2_begin.to_i, end: assignment2_end.to_i }]
end

partially_contained_pairs_count = 0

paired_groups.each do |paired_group|
  if groupA_contains_section_from_groupB?(paired_group[0], paired_group[1]) or
    groupA_contains_section_from_groupB?(paired_group[1], paired_group[0])
    partially_contained_pairs_count += 1
  end
end

puts partially_contained_pairs_count


