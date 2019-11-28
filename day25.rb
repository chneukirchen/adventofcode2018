d = File.readlines("day25").map { |x| x.split(",").map(&:to_i) }

class DSU

  def initialize(x)
    @array = Array.new(x) {|i| i }
  end

  def find(x)
    return x if @array[x] == x
    @array[x] = find(@array[x])
  end

  def union(a, b)
    @array[find(a)] = @array[find(b)]
  end

  def sets
    @array.collect{ |i| find(i) }.uniq.length
  end
  
end

dsu = DSU.new(d.size)

(0...d.size).each { |i|
  (i+1...d.size).each { |j|
    if d[i].zip(d[j]).map { |(a,b)| (a-b).abs }.sum <= 3
      dsu.union(i, j)
    end
  }
}

p dsu.sets
