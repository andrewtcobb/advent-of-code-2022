require 'set'

input = File.readlines("Day-10/input.txt", chomp: true)

class CRT
  attr_accessor :register, :crt_drawing, :crt_drawing_line, :cycle_number

  @@CYCLE_TIME_FOR_ADDING_INSTRUCTION = 2
  @@CRT_WIDTH = 40

  def initialize
    @register = 0
    @crt_drawing = Array.new
    @crt_drawing_line = ""
    @cycle_number = 0
  end

  def draw_pixel
    draw_next_line if cycle_number == @@CRT_WIDTH

    if current_pixel_lit?
      @crt_drawing_line += "#"
    else
      @crt_drawing_line += "."
    end
  end

  def draw_next_line
    @crt_drawing.push(crt_drawing_line.dup)
    @crt_drawing_line.clear
    @cycle_number = 0
  end

  def current_pixel_lit?
    return @cycle_number >= @register && @cycle_number <= @register + 2
  end

  def self.CYCLE_TIME_FOR_ADDING_INSTRUCTION
    @@CYCLE_TIME_FOR_ADDING_INSTRUCTION
  end
end

crt = CRT.new

input.each_with_index do |instruction|
  if instruction == 'noop'
    crt.draw_pixel
    crt.cycle_number += 1
  else
    value = instruction.split(' ').last.to_i

    CRT.CYCLE_TIME_FOR_ADDING_INSTRUCTION.times do
      crt.draw_pixel
      crt.cycle_number += 1
    end

    crt.register += value
  end
end

crt.draw_next_line

crt.crt_drawing.each do |line|
  puts line
end