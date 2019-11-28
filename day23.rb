file = File.read("day23")

bots = file.lines.map { |l|
  l.scan(/<(-?\d+),(-?\d+),(-?\d+)>.*r=(-?\d+)/).first.map(&:to_i)
}

strongest = bots.max_by { |x,y,z,w| w }

p bots.count { |x,y,z,w|
  ((x-strongest[0]).abs +
   (y-strongest[1]).abs +
   (z-strongest[2]).abs) <= strongest[3]
}  # 577


p bots.map { |b| b[0] }.sum 
p bots.map { |b| b[1] }.sum
p bots.map { |b| b[2] }.sum

#  16933511,19092135,15403726
# 51429372
