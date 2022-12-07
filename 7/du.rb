# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

match_cd = /^\$ cd (?<dir>.*)$/
match_up = /^\$ cd \.\.$/
match_file = /^(?<size>\d*) (?<filename>[a-z.]*)$/

dirs = [[]]
sizes = {}

lines.each do |line|
  case line
  when match_up
    dirs.pop
  when match_cd
    cd = match_cd.match(line)[:dir]
    parent = dirs.last
    dirs.push(parent + [cd])
  when match_file
    filesize = match_file.match(line)[:size].to_i
    dirs.each do |dir|
      if sizes[dir].nil?
        sizes[dir] = filesize
      else
        sizes[dir] += filesize
      end
    end
  end
end

# Part 1
sum = 0
sizes.each{|dir, s| sum += s if s <= 100000}
pp sum

# Part 2
fs = 70000000
unused = 30000000
clean = unused - (fs - sizes[[]])
result = nil
sizes.each_value do |s|
  if s >= clean
    result.nil? ? result = s : (result = s if result > s)
  end
end
pp result

