d = []
IO.foreach("day03") { |line|
  l = line.split(/\s*[#@,:\nx]\s*/).map(&:to_i)
  d << l[1..-1]
}

claims = d.map(&:first)

require 'set'

r = 0
p = {}
p2 = {}
d.each { |id,l,t,w,h|
  (l...l+w).each { |x|
    (t...t+h).each { |y|
      if p.include? [x,y]
        p2[[x,y]] = true
        claims.delete(p[[x,y]])
        claims.delete(id)
      else
        p[[x,y]] = id
      end
    }
  }
}

p p2.size
puts claims
