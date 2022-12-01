# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

elf_calories = [0]

lines.each do |line|
  elf_calories.push 0 if line == ''
  elf_calories[-1] += line.to_i if line != ''
end

pp "Top 1 Elf"
pp elf_calories.max
pp "Top 3 elves"
pp elf_calories.max(3)
pp "Top 3 elves by id"
elf_calories.max(3).each do |m|
  pp "#{m} by #{elf_calories.find_index(m)} Elf"
end
pp "Sum calories by top 3 elfes"
pp elf_calories.max(3).sum

