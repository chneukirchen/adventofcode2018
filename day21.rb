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

rip, *program = File.readlines("day21")

rip = rip.scan(/\d/)[0].to_i

program.map! { |line|
  o,a,b,c = line.split
  [o.to_sym, a.to_i, b.to_i, c.to_i]
}

regs = [0]*6
regs[0] = 0
ip = 0

or5 = 0

seen = []

# 3_000_000.times {
loop {
  break  if ip < 0 || ip >= program.size

  regs[rip] = ip
  regs = op(program[ip], regs)

  if program[ip][0] == :eqrr
    p regs[5]
    if seen.include? regs[5]
      break
    end
    seen << regs[5]
  end

  ip = regs[rip] + 1
}

p regs
p seen

# 7224964
# 13813247 first before duplicate
