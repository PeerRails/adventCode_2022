# frozen_string_literal: true

filename = 'input.txt'

lines = IO.readlines(filename, chomp: true)

pairs = lines.map{|line| eval(line)}.compact

def compare(left, right)
	while left[0] && right[0] do
		l = left.shift
		r = right.shift
		lia = l.kind_of?(Array)
		ria = r.kind_of?(Array)
		if lia && ria then
			r = compare(l, r)
			return r if r != 0
		elsif !lia && !ria
			r = l <=> r
			return r if r != 0
		elsif lia && !ria
			left.prepend(l)
			right.prepend([r])
		else 
			left.prepend([l])
			right.prepend(r)
		end
	end
	return 0 if left.empty? && right.empty?
	return -1 if left.empty?
	return +1 if right.empty?
end

sumi = 0

pairs.each_slice(2).each_with_index do |pair, i|
    left, right = pair[0], pair[-1]
    sumi += i+1 if compare(*pair) < 0
end


# Part 1
pp sumi

# Part 2
# WTF Eric?
pair2 = pairs.count{|i|compare(i,[[2]])<0}
pair6 = pairs.count{|i|compare(i,[[6]])<0}

pp (pair2)*(pair6)
