#! /usr/bin/env ruby
#

# # Q1
# s = gets.chomp
# a,b,c,d = gets.chomp.split
# a = a.to_i
# b = b.to_i
# c = c.to_i
# d = d.to_i
# if s[a].nil?
  # s[a] = '"'
# else
  # s[a] = '"' + s[a]
# b += 1
# c += 1
# d += 1
# end
# if s[b].nil?
  # s[b] = '"'
# else
# s[b] = '"' + s[b]
# c += 1
# d += 1
# end
# if s[c].nil?
  # s[c] = '"'
# else
# s[c] = '"' + s[c]
# d += 1
# end
# if s[d].nil?
  # s[d] = '"'
# else
  # s[d] = '"' + s[d]
# end
#
# puts s

### Q2
n = gets.to_i
nolm = []
n.times do |x|
  a = gets.split
  nolm[x] = a.map(&:to_i)
end

x1 = y1 = c1 = 0
nolm.each do |y|
  x1 += y[0]
end
x1 = x1 / n.to_f
nolm.each do |y|
  y1 += y[1]
end
y1 = y1 / n.to_f
nolm.each do |y|
  c1 += y[2]
end
c1 = c1 / n.to_f
puts c1
puts ([x1, y1].min)
puts c1 * ([x1, y1].min)
