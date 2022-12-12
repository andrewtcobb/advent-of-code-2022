require_relative 'monkey'
require_relative 'functions'
include Functions

input = File.readlines("Day-11/input.txt", chomp: true)

monkeys = parse_input(input)

monkeys = conduct_monkey_business(monkeys)

puts monkeys.map {|monkey| monkey.number_of_inspections}.sort.last(2).reduce(:*)
