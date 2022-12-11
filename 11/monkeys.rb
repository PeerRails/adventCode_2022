# frozen_string_literal: true

class Monkey
  attr_accessor :items
  attr_accessor :operation
  attr_accessor :divisor
  attr_accessor :test_passed
  attr_accessor :test_failed
  attr_accessor :inspect_count
  
  # Part 2
  attr_accessor :modulo

  def initialize
    @inspect_count = 0
  end

  def operate(item)
    first = @operation[:first].include?('old') ? item : @operation[:first].to_i
    second = @operation[:second].include?('old') ? item : @operation[:second].to_i
    # [first, second].inject(@operation[:operator]) / 3
    [first, second].inject(@operation[:operator]) % @modulo
  end

  def test(item)
    operate(item) % @divisor == 0 ? @test_passed : @test_failed
  end

  def clear_items
    @items = []
  end

  def throw
    @inspect_count += 1
    operate(@items.shift)
  end

end

def parse_monkeys(input)
  monkeys = []

  input.each do |line|
    case
    when line.include?("Monkey")
      monkeys.push Monkey.new
    when line.include?("Starting")
      items = /^*.Starting items: (?<items>.*)$/.match(line)
      monkeys.last.items = items[:items].split(", ").map(&:to_i)
    when line.include?("Operation:")
      operation = /^*.Operation: new = (?<first>.*) (?<operator>\+|\*) (?<second>.*)$/.match(line)
      monkeys.last.operation = {first: operation[:first], second: operation[:second], operator: operation[:operator]}
    when line.include?("Test")
      monkeys.last.divisor = line.scan(/\d/).join('').to_i
    when line.include?("true")
      monkeys.last.test_passed = line.scan(/\d/).first.to_i
    when line.include?("false")
      monkeys.last.test_failed = line.scan(/\d/).first.to_i
    end
  end

  modulo = monkeys.map{|m| m.divisor}.reduce(1, :lcm)
  monkeys.each{|m| m.modulo = modulo}
  end

  monkeys
end

def round(monkeys)
  monkeys.each_with_index do |monkey, im|
    items = monkey.items
    (0..items.size-1).each do |i|
      worry_level = items.first
      pp "Monkey #{im}: Item with worry level #{worry_level} is changed to #{monkey.operate(worry_level)} and thrown to monkey #{monkey.test(worry_level)}"
      monkeys[monkey.test(worry_level)].items.push monkey.throw
    end
  end
  monkeys
end

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

monkeys = parse_monkeys(lines)
10000.times {monkeys = round(monkeys)}

pp monkeys.sort {|a,b| b.inspect_count <=> a.inspect_count}.first(2).map(&:inspect_count).inject(:*)
