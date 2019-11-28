r = File.read("day20")

#r = "^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$"
#r = "^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$"

r.gsub!(/^\^|\$$/, '')


def dist(str)
  seen = []
  x = y = 0
  str.chars.each { |c|
    case c
    when "E"; x += 1
    when "W"; x -= 1
    when "S"; y += 1
    when "N"; y -= 1
    end
    seen << [x,y]
  }
  seen.uniq.size
end

p1 = 0
p2 = 0

stk = [""]
r.chars.each { |c|
  case c
  when "E", "S", "W", "N"
    stk.last << c
    p1 = [p1, dist(stk.last)].max
    p2 += 1  if dist(stk.last) > 1000
  when "("
    stk << stk.last.dup
  when "|"
    stk.pop
    stk << stk.last.dup
  when ")"
    stk.pop
  end
}

p p1  # 3788
p p2  # 8568

# 9558 too high
# 9557 too high
