#! /usr/bin/env ruby
#

# 1問目
# v = 0
# m = gets.to_i
# if m < 100
#   printf("%02d\n",0)
# elsif 100 <= m && m <= 5000
#   printf("%02d\n",m / 100)
# elsif 6000 <= m && m <= 30000
#   printf("%02d\n",(m / 1000) + 50)
# elsif 35000 <= m && m <= 70000
#   m = (((m / 1000) - 30 ) / 5) + 80
#   printf("%02d\n" , m)
# else m > 70000
#   puts "89"
# end
#
### 2問目
#dir = 'C'
#w = 0
#deg, dis = gets.chomp.split(" ").map(&:to_i)
#def fix_deg(deg, dis)
#  deg *= 10
#  if dis == 0
#    dir = 'C'
#  elsif deg < 1125
#    dir = 'N'
#  elsif 1125 <= deg && deg < 3375
#    dir = 'NNE'
#  elsif 3375 <= deg && deg < 5625
#    dir = 'NE'
#  elsif 5625 <= deg && deg < 7875
#    dir = 'ENE'
#  elsif 7875 <= deg && deg < 10125
#    dir  = 'E'
#  elsif 10125 <= deg && deg < 12375
#    dir = 'ESE'
#  elsif 12375 <= deg && deg < 14625
#    dir = 'SE'
#  elsif 14625 <= deg && deg < 16875
#    dir = 'SSE'
#  elsif 16875 <= deg && deg < 19125
#    dir = 'S'
#  elsif 19125 <= deg && deg < 21375
#    dir = 'SSW'
#  elsif 21375 <= deg && deg < 23625
#    dir = 'SW'
#  elsif 23625 <= deg && deg < 25875
#    dir = 'WSW'
#  elsif 23625 <= deg && deg < 28125
#    dir = 'W'
#  elsif 28125 <= deg && deg < 30375
#    dir = 'WNW'
#  elsif 30375 <= deg && deg < 32625
#    dir = 'NW'
#  elsif 32625 <= deg && deg < 34875
#    dir = 'NNW'
#  else
#    dir = 'N'
#  end
#  return dir
#end
#
#def fix_dis(dis)
#  f = (sprintf("%.1f", (dis / 60.0).round(1))).to_f
#  if f <= 0.2
#    return 0
#  elsif 0.3 <= f && f <= 1.5
#    return 1
#  elsif 1.6 <= f && f <= 3.3
#    return 2
#  elsif 3.4 <= f && f <= 5.4
#    return 3
#  elsif 5.5 <= f && f <= 7.9
#    return 4
#  elsif 8.0 <= f && f <= 10.7
#    return 5
#  elsif 10.8 <= f && f <= 13.8
#    return 6
#  elsif 13.9 <= f && f <= 17.1
#    return 7
#  elsif 17.2 <= f && f <= 20.7
#    return 8
#  elsif 20.8 <= f && f <= 24.4
#    return 9
#  elsif 24.5 <= f && f <= 28.4
#    return 10
#  elsif 28.5 <= f && f <= 32.6
#    return 11
#  elsif f >= 32.7
#    return 12
#  end
#end
#
#dis = fix_dis(dis)
#deg = fix_deg(deg, dis)
#print "#{deg} #{dis}\n"

# 4問目考え中
itenum = gets.chomp.to_i
stack = []
(itenum).times {
  s, e = gets.chomp.split("-").map(&:to_i)
  s = (s / 100 * 60) + (s % 100)
  e = (e / 100 * 60) + (e % 100)
  if (s % 5) > 0
    s -= (s % 5)
  end
  if (e % 5) > 0
    e += 5 - (e % 5)
  end
  s = s / 60 * 100 + s % 60
  e = e / 60 * 100 + e % 60
  stack.push([s,e])
}
substack = []
stack.sort!
stack.each do |x,y|
  if substack.empty?
    substack.push([x,y])
    next
  end
  substack.each_with_index do |a,i|
    xx, yy = a[0], a[1]
    x_range = y_range = false
    if xx < x && x < yy
      x_range = true
      substack[i][0] = x
    end
    if xx < y && y << yy
      y_range = true
      substack[i][1] = y
    end
    if !x_range && !y_range
      substack.push([x,y])
    end
  end
end

substack.each do |x,y|
  x = sprintf("%04d",x)
  y = sprintf("%04d",y)
  print "####\n"
  print "#{x}-#{y}\n"
end
