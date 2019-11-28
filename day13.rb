maze = File.readlines("day13")

xmaze = <<'EOF'.lines.to_a
/->-\        
|   |  /----\
| /-+--+-\  |
| | |  | v  |
\-+-/  \-+--/
  \------/   
EOF

cars = []

maze.each_with_index { |row, i|
  row.chars.each_with_index { |col, j|
    case col
    when "^"; cars << [i,j,:n,:l]; row[j] = "|"
    when ">"; cars << [i,j,:e,:l]; row[j] = "-"
    when "v"; cars << [i,j,:s,:l]; row[j] = "|"
    when "<"; cars << [i,j,:w,:l]; row[j] = "-"
    end
  }
}


cars = [
  [65, 26, :s, :r],
  [105, 39, :n, :l],
  [140, 85, :e, :r]
]

puts maze

crashed = []

loop {
  cars.sort! #_by! { |(i,j,d,s)| [j,i] }

  p cars.size
  p cars

  m = maze.map {|l|l.dup}
  cars.each { |(i,j,d,s)|
    m[i][j] = case d
              when :e; ">"
              when :n; "^"
              when :s; "v"
              when :w; "<"
              end
  }
#  puts m

  if cars.size == 1
    p cars
    break
  end

  cars.each_with_index { |(i,j,d,s),n|
    p [maze[i][j],d]
    case [maze[i][j],d]
    when ["-", :e]
      cars[n][1] += 1
    when ["-", :w]
      cars[n][1] -= 1
    when ["|", :s]
      cars[n][0] += 1
    when ["|", :n]
      cars[n][0] -= 1
    when ["+", :s]
      case s
      when :l; cars[n][1] +=1; cars[n][2] = :e; cars[n][3] = :s
      when :s; cars[n][0] +=1; cars[n][3] = :r
      when :r; cars[n][1] -=1; cars[n][2] = :w; cars[n][3] = :l
      end
    when ["+", :n]
      case s
      when :l; cars[n][1] -=1; cars[n][2] = :w; cars[n][3] = :s
      when :s; cars[n][0] -=1; cars[n][3] = :r
      when :r; cars[n][1] +=1; cars[n][2] = :e; cars[n][3] = :l
      end
    when ["+", :e]
      case s
      when :l; cars[n][0] -=1; cars[n][2] = :n; cars[n][3] = :s
      when :s; cars[n][1] +=1; cars[n][3] = :r
      when :r; cars[n][0] +=1; cars[n][2] = :s; cars[n][3] = :l
      end
    when ["+", :w]
      case s
      when :l; cars[n][0] +=1; cars[n][2] = :s; cars[n][3] = :s
      when :s; cars[n][1] -=1; cars[n][3] = :r
      when :r; cars[n][0] -=1; cars[n][2] = :n; cars[n][3] = :l
      end
    when ["\\", :e]
      cars[n][2] = :s
      cars[n][0] += 1
    when ["/", :e]
      cars[n][2] = :n
      cars[n][0] -= 1
    when ["\\", :n]
      cars[n][2] = :w
      cars[n][1] -= 1
    when ["/", :n]
      cars[n][2] = :e
      cars[n][1] += 1
    when ["\\", :s]
      cars[n][2] = :e
      cars[n][1] += 1
    when ["/", :s]
      cars[n][2] = :w
      cars[n][1] -= 1
    when ["/", :w]
      cars[n][2] = :s
      cars[n][0] += 1
    when ["\\", :w]
      cars[n][2] = :n
      cars[n][0] -= 1
    else
      p [:miss, maze[i][j], d]
    end

    if cars.each.with_index.any? { |(i2,j2,_,_,m)| i == i2 && j == j2 && n != m }
      if crashed.empty?
        p [:crash, j, i]
      end
      crashed << true
      cars.delete_at n
      cars.delete_if { |(i2,j2,_,_,m)| i == i2 && j == j2 }
    end

  }
}

p cars

# 32,8 ok
# 38,38

