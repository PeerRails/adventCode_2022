# frozen_string_literal: true

filename = 'input.txt'

datastream = IO.read(filename)

packet_markers = []
message_markers = []

datastream.chars.each_cons(4).to_a.each_with_index {|a, i| packet_markers << i if a.uniq.size == 4}
datastream.chars.each_cons(14).to_a.each_with_index {|a, i| message_markers << i if a.uniq.size == 14}

# Part 1
pp packet_markers.first+4

# Part 2
pp message_markers.select{|m| m > packet_markers.first+3}.first + 14
