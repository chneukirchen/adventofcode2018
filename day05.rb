t = s = File.read("day05").chomp

v = ('a'..'z').map { |l| ["#{l}#{l.upcase}", "#{l.upcase}#{l}"] }.flatten
r = Regexp.union v

p r

while s.gsub!(r, '')
end

p s.size

# 9687 too high

p ('a'..'z').map { |l|
  s = t.delete "#{l}#{l.upcase}"
  while s.gsub!(r, '')
  end
  p [l, s.size]
  s.size
}.min
