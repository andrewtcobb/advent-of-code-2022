require 'set'
input = File.readlines("Day-6/input.txt", chomp: true)

buffer = []
input[0].chars.each_with_index do |char, i|
  BUFFER_SIZE = 14
  if Buffer.size >= BUFFER_SIZE
    if buffer.to_set.size == buffer.size
      puts i
      break
    else
      buffer.pop
    end
  end
  buffer.prepend(char)
end
