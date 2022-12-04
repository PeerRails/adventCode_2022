# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

require 'set'

p1 = 0
p2 = 0
pairs = []

lines.each do |line|
  ranges = line.split(',').map{|r| Range.new(*r.split('-').map(&:to_i))}
  p1 += 1 if (ranges[0].cover?(ranges[1]) || ranges[1].cover?(ranges[0]))
  p2 += 1 if (ranges[0].to_set.intersect?(ranges[1].to_set))
end

pp p1
pp p2


