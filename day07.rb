p1 = {}
p2 = {}

IO.foreach("day07") { |line|
  (p1[line[36]] ||= []) << line[5]
  (p2[line[5]] ||= []) << line[36]
  p2[line[36]] ||= []
}

q = p1.values.concat.flatten - p1.keys

fin = []
until q.empty?
  q.sort!
  q.uniq!
  c = q.shift

  print c  unless fin.include? c
  fin << c

  p1.each { |k,v|
    q << k  if (v - fin).empty? && !fin.include?(k)
  }
end
puts # BDHNEGOLQASVWYPXUMZJIKRTFC


t = 0
w = [nil]*5

until p2.empty?
  w.each_with_index { |j, i|
    if j && j[1] == t
      w[i] = nil
      p2.delete(j[0])
    end
  }

  w.each_with_index { |j, i|
    if !j && wn = p2.keys.find { |n|
         p2.none? { |k,v| v.include? n } && w.none? { |j| j && n.include?(j[0]) }
       }
      w[i] = [wn, t + wn.ord - 64 + 60]
    end
  }

  t += 1
end

p t-1

# 1107
