# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

p1_points = 0
p2_points = 0

lines.each do |line|
  case line
  when "A X"
    p1_points += 4
    p2_points += 3
  when "B X"
    p1_points += 1
    p2_points += 1
  when "C X"
    p1_points += 7
    p2_points += 2
  when "A Y"
    p1_points += 8
    p2_points += 4
  when "B Y"
    p1_points += 5
    p2_points += 5
  when "C Y"
    p1_points += 2
    p2_points += 6
  when "A Z"
    p1_points += 3
    p2_points += 8
  when "B Z"
    p1_points += 9
    p2_points += 9
  when "C Z"
    p1_points += 6
    p2_points += 7
  else
    p1_points += 0
    p2_points += 0
  end
end 

pp "Part One Points"
pp p1_points

pp "Part Two Points"
pp p2_points

