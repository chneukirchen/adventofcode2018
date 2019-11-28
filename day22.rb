DEPTH = 11739
TX, TY = 11, 718

#DEPTH = 510
#TX, TY = 10, 10

$GI = {}
def gi(x,y)
  $GI[[x,y]] ||=
  if (x == 0 && y == 0) || (x == TX && y == TY)
    0
  elsif y == 0
    x * 16807
  elsif x == 0
    y * 48271
  else
    el(x-1,y) * el(x,y-1)
  end
end

def el(x,y)
  (gi(x,y) + DEPTH) % 20183
end

p gi(0,0)
p el(1,1)

p1 = 0
(0..TX).each { |x|
  (0..TY).each { |y|
    p1 += el(x,y)%3
  }
}
p p1  # 8735
