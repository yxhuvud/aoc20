require "complex"

inputs =
  File.read("input.day12")
    .scan(/(.)(\d+)/)
    .map { |m| {m[1][0], m[2].to_i} }

def deg_to_complex(deg)
  case deg
  when  90 then Complex.new(0, 1)
  when 180 then -1
  when 270 then Complex.new(0, -1)
  else          raise "Unreachable"
  end
end

pos = Complex.zero
dir = Complex.new(0, 1)
inputs.each do |command, by|
  case command
  when 'N' then pos += by
  when 'S' then pos -= by
  when 'E' then pos += Complex.new(0, by)
  when 'W' then pos -= Complex.new(0, by)
  when 'L' then dir *= deg_to_complex(360 - by)
  when 'R' then dir *= deg_to_complex(by)
  when 'F' then pos += by * dir
  else          raise "Unreachable"
  end
end
puts "part1: %s" % (pos.real.abs + pos.imag.abs).to_i

pos = Complex.zero
waypoint = Complex.new(1, 10)
inputs.each do |command, by|
  case command
  when 'N' then waypoint += by
  when 'S' then waypoint -= by
  when 'E' then waypoint += Complex.new(0, by)
  when 'W' then waypoint += Complex.new(0, -by)
  when 'L' then waypoint *= deg_to_complex(360 - by)
  when 'R' then waypoint *= deg_to_complex(by)
  when 'F' then pos += waypoint * by
  else          raise "Unreachable"
  end
end

puts "part2: %s" % (pos.real.abs + pos.imag.abs).to_i
