# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

snake = Array.new(9) { [0,0] } 
tail = { [0,0] => 1}
x = 0
y = 0

lines.each do |line|
  direction, steps = line.split(" ")
  steps.to_i.times do
    case direction
    when 'R'
      x += 1
    when 'L'
      x -= 1
    when 'U'
      y += 1
    when 'D'
      y -= 1
    end
    cx, cy = x,y
    snake.each do |s|
      sx, sy = s
      if (sx - cx).abs > 1 || (sy - cy).abs >1
        sx += sx < cx ? 1 : sx > cx ? -1 : 0
        sy += sy < cy ? 1 : sy > cy ? -1 : 0
      end
      cx, cy = sx, sy
      s[0] = sx
      s[1] = sy
    end
    tail[snake[-1].dup] = 1
  end
end

p snake
p tail.size
