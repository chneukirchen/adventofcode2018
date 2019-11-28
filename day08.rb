d=File.read("day08").split.map(&:to_i)

def t(d)
  return 0  if d.empty?

  len = d.shift
  md = d.shift

  mds = 0
  (0...len).map {
    mds += t(d)
  }
  mds += d.shift(md).sum
end

def s(d)
  return 0  if d.empty?

  len = d.shift
  md = d.shift

  mds = (0...len).map {
    s(d)
  }
  
  m = d.shift(md)

  if len == 0
    m.sum
  else
    m.map { |i|
      if i <=0 || i > mds.size
        0
      else
        mds[i-1]
      end
    }.sum
  end
end

p t(d.clone)  # 35852
p s(d.clone)  # 33422

