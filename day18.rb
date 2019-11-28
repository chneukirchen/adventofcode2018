d = ["\n", *File.readlines("day18").map { |x| " " + x }, "\n"]


=begin
    An open acre will become filled with trees if three or more adjacent acres contained trees. Otherwise, nothing happens.
    An acre filled with trees will become a lumberyard if three or more adjacent acres were lumberyards. Otherwise, nothing happens.
    An acre containing a lumberyard will remain a lumberyard if it was adjacent to at least one other lumberyard and at least one acre containing trees. Otherwise, it becomes open.
=end


xd = <<EOF.lines.to_a

 .#.#...|#.
 .....#|##|
 .|..|...#.
 ..|#.....#
 #.#|||#|#|
 ...#.||...
 .|....|...
 ||...#|.#|
 |.||||..|.
 ...#.|..|.

EOF

require 'pp'

seen = []

p1 = 0

i = 0
d2 = nil
1000.times { |i|
pp d

d2 = d.map(&:clone)

d.each_index { |i|
  d[i].chars.each_index { |j|
    case d[i][j]
    when '.'
      if [d[i-1][j-1], d[i-1][j], d[i-1][j+1],
          d[i  ][j-1],            d[i  ][j+1],
          d[i+1][j-1], d[i+1][j], d[i+1][j+1]].count('|') >= 3
        d2[i][j] = '|'
      end
    when '|'
      if [d[i-1][j-1], d[i-1][j], d[i-1][j+1],
          d[i  ][j-1],            d[i  ][j+1],
          d[i+1][j-1], d[i+1][j], d[i+1][j+1]].count('#') >= 3
        d2[i][j] = '#'
      end
    when '#'
      s = [d[i-1][j-1], d[i-1][j], d[i-1][j+1], :X,
           d[i  ][j-1],            d[i  ][j+1], :Y,
           d[i+1][j-1], d[i+1][j], d[i+1][j+1]]
      if s.include?('#') && s.include?('|')
        # keep
      else
        d2[i][j] = '.'
      end
    end
  }
}

if seen.include? d2
  p [:cycle, i, seen.size - seen.index(d2)]
  break
else
  seen << d2
end

if i == 10
  r = d.join
  p1 = r.count('#') * r.count('|')   # 535522
end

d = d2
r = d.join
}


p p1

n = (1000000000-i)%(seen.size - seen.index(d2))

p seen.map { |s|
r = s.join
p2 = r.count('#') * r.count('|')
}.index(210160)

#p p2

# 210160
