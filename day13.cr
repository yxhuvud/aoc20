require "big"

input = File.read_lines("input.day13")

at = input.first.to_i
buses = input[1].scan(/\d+/).map { |m| m[0].to_i }
puts "part1: %s" % buses.map { |b| {b - (at % b), b} }.min.product

buses = input[1].split(/,/)
  .map { |x| x == "x" ? nil : x.to_i64 }
  .each_with_index
  .select(&.first)
  .map { |(x, i)| {x.not_nil!, i.to_i64} }
  .to_a

buses = buses.map { |x, y| {x, y % x} }
part2 = buses.reduce do |(acc, val), (period, offset)|
  multiplier = (1..period).find { |x|
    (offset + val + acc * x) % period == 0
  }
  raise "didn't find" unless multiplier

  {acc * period, (val + acc * multiplier)}
end
puts "part2: #{part2[1]}"
