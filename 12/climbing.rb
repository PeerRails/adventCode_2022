# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

require "set"

H = ['S', *("a".."z").to_a, 'E'].each_with_index.to_h


