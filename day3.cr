inputs = File
  .read("input.day3")
  .split

def trees(inputs, right, down)
  y = -right
  row_size = inputs[0].size
  0.step(to: inputs.size - 1, by: down).count do |x|
    y += right
    y -= row_size if y >= row_size
    inputs[x][y] == '#'
  end
end

puts "part1: #{trees(inputs, 3, 1)}"

paths = { {1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2} }
  .product(1i64) { |right, down| trees(inputs, right, down) }

puts "part2: #{paths}"
