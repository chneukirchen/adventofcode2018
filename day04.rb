d = []
IO.foreach("day04") { |line|
  d << line.split(/[\[\]:# ]/)
}

d.sort!

g = nil
s = nil
zg = Hash.new 0
zgt = Hash.new 0
d.each { |l|
  case l[5]
  when "Guard"
    g = l[7].to_i
  when "falls"
    s = l[3].to_i
  when "wakes"
    (s...l[3].to_i).each { |t|
      zg[g] += 1
      zgt[[g,t]] += 1
    }
  end
}

a = zg.max_by { |k,v| v }.first
b = zgt.max_by { |(g,t),v| g == a ? v : 0 }[0][1]
p a * b
# => 131469

p zgt.max_by { |k,v| v }[0].inject(:*)
# => 96951
