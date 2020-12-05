inputs = File
  .read("input.day5")
  .tr("BFRL", "1010")
  .split
  .map(&.to_i(2))
  .to_set

puts "part1: #{inputs.max}"
puts "part2: %d" % (inputs.select { |x| !(x + 1).in?(inputs) }.min + 1)
