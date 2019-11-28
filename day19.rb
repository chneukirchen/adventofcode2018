insn = [:eqri, :seti, :eqir, :eqrr, :addi, :setr, :gtrr, :gtir, :muli, :bori, :bani, :borr, :gtri, :banr, :addr, :mulr]

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


r0 = 0
r3=10551348

f = [1,
 2,
 3,
 4,
 6,
 9,
 12,
 18,
 36,
 293093,
 586186,
 879279,
 1172372,
 1758558,
 2637837,
 3517116,
 5275674,
 10551348]

f.each { |r1|
  f.each { |r5|
    if r1*r5 == r3
      r0 += r1
    end
  }
}

p r0


rip, *program = File.readlines("day19")

rip = rip.scan(/\d/)[0].to_i

program.map! { |line|
  o,a,b,c = line.split
  [o.to_sym, a.to_i, b.to_i, c.to_i]
}

regs = [0]*6
regs[0] = 1
ip = 0

loop {
  break  if ip < 0 || ip > program.size

  regs[rip] = ip
  p regs
  regs = op(program[ip], regs)
  ip = regs[rip] + 1
}

p regs.first  # 2240

# 10844452 too low
