inputs =
  File.read_lines("input.day11")
    .map &.chars

puts "part1: %s" % iterate(inputs, 4) { |map, i, j| neighbours_p1(map, i, j) }
puts "part2: %s" % iterate(inputs, 5) { |map, i, j| neighbours_p2(map, i, j) }

def iterate(inputs, count)
  tick = inputs.map &.dup
  tock = inputs.map &.dup
  q1 = Array(Tuple(Int32, Int32)).new initial_capacity: tick.size * tick[0].size
  q2 = q1.dup
  tick.size.times do |i|
    tick[0].size.times do |j|
      q1 << {i, j} unless tick[i][j] == '.'
    end
  end

  while q1.size > 0
    q1.each do |i, j|
      seat = tick[i][j]
      tock[i][j] =
        case yield(tick, i, j)
        when 0       then 'L'
        when count.. then '#'
        else              seat
        end
      q2 << {i, j} if tock[i][j] != seat
    end
    tick, tock = tock, tick
    q1.clear
    q1, q2 = q2, q1
  end
  tick.sum &.count('L')
end

def neighbours_p1(map, x, y)
  neighbours
    .map { |i, j| {x + i, y + j} }
    .count { |x, y| bounds?(map, x, y) && map[x][y] == 'L' }
end

def neighbours_p2(map, x, y)
  neighbours.count do |i, j|
    occupied?(map, i, j, x, y)
  end
end

def bounds?(map, x, y)
  (0...map.size).covers?(x) && (0...map[0].size).covers?(y)
end

macro neighbours
  {
    {-1, +1}, {0, +1}, {+1, +1},
    {-1, 0}, {+1, 0},
    {-1, -1}, {0, -1}, {+1, -1},
  }
end

def occupied?(map, i, j, x, y)
  x, y = x + i, y + j
  return false unless bounds?(map, x, y)

  case map[x][y]
  when 'L' then return true
  when '#' then return false
  else          occupied?(map, i, j, x, y)
  end
end
