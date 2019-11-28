s = [0]

m = 1
i = 0

mp = 9
mr = 25

mp = 10
mr = 1618
=begin

mp = 13
mr = 7999

mp, mr =  File.read("day09").scan(/\d+/).map(&:to_i)
mr *= 100  # part 2

p mr
=end

scores = Hash.new(0)

catch(:done) {
loop {
  (1..mp).each { |p|
    print m, " ", i, " ", s.size, " "
    p s

    if m % 23 == 0
      scores[p] += m
      print "score1 #{p} #{m}\n"
      i = (i - 8) % s.size
      print "score2 #{p} #{s[i]}\n"
      scores[p] += s.delete_at(i)
      
      i = (i+1)%s.size
      m += 1
    else
      i += 1
      s.insert(i, m)
      i = (i+1)%s.size
      m += 1
    end

    p m  if m % 100000 == 0

    throw :done if m >= mr+1
  }
}
}

p scores
p scores.values.max  # 382055
