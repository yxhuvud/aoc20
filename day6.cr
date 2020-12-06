inputs = File
  .read("input.day6")
  .split("\n\n")
  .map &.split
    .map &.chars
      .to_set

puts "part1: %d" % inputs.sum {|group| group.reduce {|acc, p| acc | p }.size }
puts "part2: %d" % inputs.sum {|group| group.reduce {|acc, p| acc & p }.size }
