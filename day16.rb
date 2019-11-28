def op(cmd, regs)
  regs2 = regs.dup

  case cmd[0]
  when :addr; regs2[cmd[3]] = regs[cmd[1]] + regs[cmd[2]]
  when :addi; regs2[cmd[3]] = regs[cmd[1]] + cmd[2]
  when :mulr; regs2[cmd[3]] = regs[cmd[1]] * regs[cmd[2]]
  when :muli; regs2[cmd[3]] = regs[cmd[1]] * cmd[2]
  when :banr; regs2[cmd[3]] = regs[cmd[1]] & regs[cmd[2]]
  when :bani; regs2[cmd[3]] = regs[cmd[1]] & cmd[2]
  when :borr; regs2[cmd[3]] = regs[cmd[1]] | regs[cmd[2]]
  when :bori; regs2[cmd[3]] = regs[cmd[1]] | cmd[2]
  when :setr; regs2[cmd[3]] = regs[cmd[1]]
  when :seti; regs2[cmd[3]] = cmd[1]
  when :gtir; regs2[cmd[3]] = cmd[1] > regs[cmd[2]] ? 1 : 0
  when :gtri; regs2[cmd[3]] = regs[cmd[1]] > cmd[2] ? 1 : 0
  when :gtrr; regs2[cmd[3]] = regs[cmd[1]] > regs[cmd[2]] ? 1 : 0
  when :eqri; regs2[cmd[3]] = regs[cmd[1]] == cmd[2] ? 1 : 0
  when :eqir; regs2[cmd[3]] = cmd[1] == regs[cmd[2]] ? 1 : 0
  when :eqrr; regs2[cmd[3]] = regs[cmd[1]] == regs[cmd[2]] ? 1 : 0
  end

  regs2
end

OPS = [:addr, :addi, :mulr, :muli, :banr, :bani, :borr, :bori, :setr, :seti,
 :gtri, :gtir, :gtrr, :eqri, :eqir, :eqrr]

OPS.each { |o|
  
  if op([o, 2, 1, 2], [3, 2, 1, 1]) == [3, 2, 2, 1]
    p o
  end
}

p1 = 0

poss = Array.new(16) { OPS }

code = nil

File.read("day16").split("\n\n").each { |samp|
  if samp =~ /^Before:/
    x = samp.lines.map { |l| l.scan(/\[.*?\]/) }
    before = eval(x[0].first)
    unop, *args = samp.lines[1].split(' ').map(&:to_i)
    after = eval(x[2].first)

    n = OPS.find_all { |o|
      op([o, *args], before) == after
    }
    
    poss[unop] &= n

    if n.size >= 3
      p1 += 1
    end
  else
    code = samp
  end
}

p p1

require 'pp'

pp poss

loop {
  det = poss.find_all { |p| p.size == 1 }.flatten
  break  if det.size == 16
  poss.each_index { |i|
    poss[i] -= det  unless poss[i].size == 1
  }
}

poss.map!(&:first)

p poss

regs = [0,0,0,0]
code.each_line { |l|
  numop, *args = l.split(' ').map(&:to_i)
  regs = op([poss[numop], *args], regs)
}
p regs[0]

__END__

Before: [3, 2, 1, 1]
9 2 1 2
After:  [3, 2, 2, 1]
