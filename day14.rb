d = 360781

s = [3,7]
e1 = 0
e2 = 1

30_000_000.times {
#  p [:X, e1, e2, s[e1], s[e2]]
  c = (s[e1] + s[e2]).to_s.split('').map(&:to_i)
  s.concat c
  e1 = (e1 + 1 + s[e1]) % s.size
  e2 = (e2 + 1 + s[e2]) % s.size

#  p s

#  p s.size-6  if  s[-7]==3&&s[-6]==6&&s[-5]==0&&s[-4]==7&&s[-3]==9&&s[-2]==1
#  p s.size-6  if  s[-6]==3&&s[-5]==6&&s[-4]==0&&s[-3]==7&&s[-2]==9&&s[-1]==1
}

p s.size
p s[d,10].join('')
# 6521571010

p s.join('').index d.to_s
# 20262967
