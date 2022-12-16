# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

class Sensor
  attr_reader :x, :y, :beacon_x, :beacon_y, :min_range

  def initialize(line)
    if line =~ /\ASensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)\z/
      @x = Regexp.last_match(1).to_i
      @y = Regexp.last_match(2).to_i
      @beacon_x = Regexp.last_match(3).to_i
      @beacon_y = Regexp.last_match(4).to_i
    else
      raise "Malformed line: '#{line}'"
    end
    @min_range = (@x - @beacon_x).abs + (@y - @beacon_y).abs
  end

  def in_range_of(x, y)
    (@x - x).abs + (@y - y).abs <= @min_range
  end
end

sensors = lines.map { |line| Sensor.new(line) }

# Part 1
xs = sensors.flat_map { |s| [s.x - s.min_range, s.x + s.min_range] }
part1_y = 2000000; 
#file = 'example1'; @part1_y = 10; @part2_max = 20

in_range_x = 0
xs.min.upto(xs.max) do |x|
  in_range_x += 1 if sensors.any? { |s| s.in_range_of(x, part1_y) } and not sensors.any? { |s| s.beacon_x == x and s.beacon_y == part1_y }
end

pp in_range_x

# Part 2
# At y=2000000, 4502208 positions can't contain a beacon
# Beacon at x=3446137, y=3204480. Tuning frequency: 13784551204480
part2_max = 4000000
pos_range = 0..part2_max
def find_beacon(sensors, pos_range)
  # Since we want to find a _single_ point not in range of any sensor, it must
  # be _just_ outside the range of all nearby sensors.
  # Therefore, checking all positions in the ring one step away from being in
  # range of each sensor, we will find the position not in range of any sensor.
  sensors.each do |s|
    range = s.min_range + 1
    [-1, 1].each do |y_dir|
      [-1, 1].each do |x_dir|
        0.upto(range) do |dx|
          dy = range - dx
          x = s.x + dx * x_dir
          next unless pos_range.include?(x)
          y = s.y + dy * y_dir
          next unless pos_range.include?(y)
          if not sensors.any? { |s| s.in_range_of(x, y) }
            return x, y
          end
        end
      end
    end
  end
end
x, y = find_beacon(sensors, pos_range)

pp "Beacon at x=#{x}, y=#{y}. Tuning frequency: #{x * 4000000 + y}"
