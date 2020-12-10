inputs =
  File.read("input.day10")
    .split
    .map(&.to_i)
    .<<(0)
    .sort
inputs << inputs.last + 3

part1 = inputs.each_cons(2, reuse: true)
  .map { |(a, b)| b - a }
  .tally
  .values
  .product

paths_to = {0 => 1i64}
inputs.each_with_index do |val, i|
  inputs[i + 1..i + 3].each do |j|
    break if j > val + 3

    paths_to[j] ||= 0i64
    paths_to[j] += paths_to[val]
  end
end

puts "part1: #{part1}"
puts "part2: %s" % paths_to.values.max
