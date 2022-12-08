# frozen_string_literal: true

filename = 'input.txt'

map = IO.readlines(filename, chomp: true).map{|line| line.chars.map(&:to_i)}
height = map.size
width = map[0].size
each_tree = (0...height).flat_map { |i| (0...width).map { [i, _1] } }

left = -> ((i, j)) { (0...j).reverse_each.map { [i, _1] } }
right = -> ((i, j)) { (j + 1...width).map { [i, _1] } }
up = -> ((i, j)) { (0...i).reverse_each.map { [_1, j] } }
down = -> ((i, j)) { (i + 1...height).map { [_1, j] } }
directions = [left, right, up, down]

height_of = -> ((i, j)) { map[i][j] }
heights = -> directions { directions.map(&height_of) }
rays = -> tree { directions.map { _1[tree] } }

# Part 1
is_visible = -> tree { -> ray { ray.map(&height_of).all? { _1 < height_of[tree] } } }
p each_tree.count { |a| rays[a].map(&is_visible[a]).any? }

# Part 2
score = -> tree { -> ray { ray.map(&height_of).slice_after { _1 >= height_of[tree] }.first&.count || 0 } }
p each_tree.map { |a| rays[a].map(&score[a]).inject(&:*) }.max
