# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)
# Stack Index
# 1 1
# 2 5
# 3 9
# 4 13
# 5 17
# 6 21
# 7 25
# 8 29
# 9 33

cargo_p1 = Array.new(10){[]}
cargo_p2 = Array.new(10){[]}
commands = []

# normalize stack
def ns(s) = [0,1,5,9,13,17,21,25,29,33].find_index(s)


lines.each_with_index do |line,index|
  line.chars.each_with_index do |ch, char_index|
    cargo_p1[ns(char_index)].unshift ch if /[A-Z]/.match(ch)
    cargo_p2[ns(char_index)].unshift ch if /[A-Z]/.match(ch)
  end
  # Quantity[0], from[1], to[2]
  commands.push(line.scan(/\d+/).map(&:to_i)) if line.include? 'move'
end

# Part 1
commands.each do |qty,from,to|
  crates = cargo_p1[from].pop(qty)
  crates.reverse_each{|c| cargo_p1[to].push(c)}
end

# Part 2
commands.each do |qty,from,to|
  crates = cargo_p2[from].pop(qty)
  crates.each{|c| cargo_p2[to].push(c)}
end

pp cargo_p1.map{|line| line.last}
pp cargo_p2.map{|line| line.last}

