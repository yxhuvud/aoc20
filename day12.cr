require "complex"

inputs =
  File.read("input.day12")
    .scan(/(.)(\d+)/)
    .map { |m| {m[1][0], m[2].to_i} }

def deg_to_complex(deg)
  case deg
  when 90
    Complex.new(0, 1)
  when 180
    -1
  when 270
    Complex.new(0, -1)
  else raise "Unreachable"
  end
end

pos = Complex.zero
dir = Complex.new(0, 1)
inputs.each do |command, by|
  case command
  when 'N'
    pos += by
  when 'S'
    pos -= by
  when 'E'
    pos += Complex.new(0, by)
  when 'W'
    pos -= Complex.new(0, by)
  when 'L'
    dir *= deg_to_complex(360 - by)
  when 'R'
    dir *= deg_to_complex(by)
  when 'F'
    pos += by * dir
  else raise "Unreachable"
  end
end
puts "part1: %s" % (pos.real.abs + pos.imag.abs).to_i

pos = Complex.zero
waypoint = Complex.new(1, 10)
inputs.each do |command, by|
  case command
  when 'N'
    waypoint += by
  when 'S'
    waypoint -= by
  when 'E'
    waypoint += Complex.new(0, by)
  when 'W'
    waypoint += Complex.new(0, -by)
  when 'L'
    waypoint *= deg_to_complex(360 - by)
  when 'R'
    waypoint *= deg_to_complex(by)
  when 'F'
    pos += waypoint * by
  else raise "Unreachable"
  end
end

puts "part2: %s" % (pos.real.abs + pos.imag.abs).to_i
