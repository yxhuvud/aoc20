inputs = # Warning: assumes input that is > 0.
  File.read("input.day9")
    .split
    .map(&.to_i64)

def is_sum?(nums, needle)
  nums.find do |x|
    nums.find { |y| x + y == needle }
  end
end

def finder(inputs)
  inputs.each_cons(26, reuse: Deque(Int64).new) do |is|
    return is.last unless is_sum?(is, is.last)
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
