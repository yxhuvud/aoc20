inputs = File
  .read("input.day3")
  .split

def trees(inputs, right, down)
  y = 0
  row_size = inputs[0].size
  trees = 0i64
  0.step(to: inputs.size - 1, by: down) do |x|
    trees += 1 if inputs[x][y] == '#'
    y += right
    y -= row_size if y >= row_size
  end
  trees
end

puts "part1: #{trees(inputs, 3, 1)}"

paths = { {1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2} }
  .map { |right, down| trees(inputs, right, down) }

puts "part2: #{paths.product}"
