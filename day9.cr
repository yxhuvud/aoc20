inputs =
  File.read("input.day9")
    .split
    .map(&.to_i64)

def is_sum?(nums, needle)
  nums.find do |x|
    nums.find { |y| x + y == needle }
  end
end

def finder(inputs)
  queue = Deque(Int64).new
  inputs.each do |i|
    if queue.size > 25
      is_sum?(queue, i) ? queue.shift : return i
    end
    queue.push i
  end
  raise "Unreachable"
end

def finder2(inputs, num)
  queue = Deque(Int64).new
  sum = 0i64
  inputs.each do |i|
    return queue.minmax.sum if sum == num

    while sum > num
      sum -= queue.shift
    end
    if sum < num
      sum += i
      queue.push i
    end
  end
end

num = finder(inputs)
puts "part1 #{num}"
puts "part2 #{finder2(inputs, num)}"
