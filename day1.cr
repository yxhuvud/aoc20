inputs = File
  .read("input.day1")
  .split
  .map(&.to_i)
  .sort # cuts run time to a 10th..

def find(inputs, n)
  inputs
    .each_combination(n, reuse: true)
    .find { |x| x.sum == 2020 } ||
    raise "not found"
end

puts "part1: %s" % find(inputs, 2).product
puts "part2: %s" % find(inputs, 3).product
