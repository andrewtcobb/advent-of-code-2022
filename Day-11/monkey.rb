class Monkey
  attr_accessor :items, :operation, :test_number, :monkey_to_throw_to_if_test_passes, :monkey_to_throw_to_if_test_fails, :number_of_inspections

  def initialize
    @items = Array.new
    @operation = nil
    @test_number = 0
    @monkey_to_throw_to_if_test_passes = 0
    @monkey_to_throw_to_if_test_fails = 0
    @number_of_inspections = 0
  end

  def passes_test?(item)
    return item % @test_number == 0
  end
end
