# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

require "set"

H = [" ", *("a".."z").to_a, *("A".."Z").to_a].each_with_index.to_h

def common(xs) = xs.map(&:to_set).reduce(:&).first

I = lines.map { _1.chars.map &H }
S = I.map { common(_1.each_slice(_1.size / 2)) }.sum
G = I.each_slice(3).map { common(_1) }.sum

p S, G

