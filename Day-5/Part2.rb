input = File.readlines("Day-5/input.txt", chomp: true)

stacks = [%w[N S D C V Q T], %w[M F V], %w[F Q W D P N H M],%w[D Q R T F], %w[R F M N Q H V B], %w[C F G N P W Q], %w[W F R L C T], %w[T Z N S], %w[M S D J R Q H N]]

instructions = []

has_reached_instructions = false
input.each do |line|
  if !has_reached_instructions && line.empty?
    has_reached_instructions = true
  elsif has_reached_instructions
    numbers = line.split(" ").filter {|word| word.to_i.to_s == word}
    instructions.push({num_boxes_to_move: numbers[0].to_i, from: numbers[1].to_i-1, to: numbers[2].to_i-1})
  end
end

instructions.each do |instruction|
  boxes_to_move = []
  instruction[:num_boxes_to_move].times do
    if !stacks[instruction[:from]].empty?
      boxes_to_move.push(stacks[instruction[:from]].pop)
    end
  end
  stacks[instruction[:to]] += boxes_to_move.reverse
  boxes_to_move.clear
end

stacks.each { |stack| puts stack.last}
