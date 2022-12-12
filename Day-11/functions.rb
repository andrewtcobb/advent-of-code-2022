module Functions
  def create_operation(operator, number)
    case operator
    when "+"
      return number == "old" ? -> (old) { old + old } : -> (old) { old + number.to_i }
    when "*"
      return number == "old" ? -> (old) { old * old } : -> (old) { old * number.to_i }
    end
  end

  def parse_input(input)
    monkeys = []
    input.each_with_index do |line, index|
      if index % 7 == 0
        monkey = Monkey.new

        monkey.items = input[index + 1].split(": ").last.split(", ").map(&:to_i).reverse
        monkey.test_number = input[index + 3].split(" ").last.to_i
        operator, number = input[index + 2].split(" ").last(2)
        monkey.operation = create_operation(operator, number)
        monkey.monkey_to_throw_to_if_test_passes = input[index + 4].split(" ").last.to_i
        monkey.monkey_to_throw_to_if_test_fails = input[index + 5].split(" ").last.to_i

        monkeys.push(monkey)
      end
    end
    return monkeys
  end

  def conduct_monkey_business(monkeys)
    20.times do
      monkeys.each do |monkey|
        unless monkey.items.empty?
          monkey.items.size.times do
            item = monkey.items.pop
            item = monkey.operation.call(item)
            item = (item / 3).round
            if monkey.passes_test?(item)
              monkeys[monkey.monkey_to_throw_to_if_test_passes].items.prepend(item)
            else
              monkeys[monkey.monkey_to_throw_to_if_test_fails].items.prepend(item)
            end

            monkey.number_of_inspections += 1
          end
        end
      end
    end
    return monkeys
  end
end
