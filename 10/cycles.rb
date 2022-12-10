# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)
add_value = /^addx (?<value>(-\d*|\d*))$/
crt = {x: 1, cycle: 0, history: {}}
output = []
def render_image(cycle, x) = (cycle % 40 - x).abs <= 1 ? '#' : '.'

lines.each_with_index do |line, i|
  case line
  when /^noop/
    crt[:history][crt[:cycle]] = crt[:x]
    crt[:cycle] += 1
    output << render_image(crt[:cycle], crt[:x])
  when add_value
    crt[:history][crt[:cycle]] = crt[:x]
    output << render_image(crt[:cycle], crt[:x])
    crt[:cycle] += 1
    crt[:history][crt[:cycle]] = crt[:x]
    output << render_image(crt[:cycle], crt[:x])
    crt[:cycle] += 1
    crt[:x] += add_value.match(line)[:value].to_i
  end
end

pp [20,60,100,140,180,220].sum{ |i| crt[:history][i-1] * i }
pp output.each_slice(40).map {|i| i.join }

