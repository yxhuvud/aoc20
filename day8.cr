record(Op, op : String, val : Int32)

def program(inputs, pcounter = 0, acc = 0)
  seen = Set(Int32).new
  while seen.add?(pcounter)
    current = inputs[pcounter]? || return {true, acc}
    pcounter += current.op == "jmp" ? current.val : 1
    acc += current.val if current.op == "acc"
  end
  {false, acc}
end

inputs =
  File.read("input.day8")
    .scan(/(.*) ([+-]\d+)/)
    .map { |(_, op, val)| Op.new(op, val.to_i) }

ending_swap =
  inputs.each_index.select { |i| inputs[i].op.in?({"nop", "jmp"}) }
    .map do |index|
      op = inputs[index]
      inputs[index] = Op.new(inputs[index] == "nop" ? "jmp" : "nop", op.val)
      program(inputs).tap { inputs[index] = op }
    end
    .find(&.first)

puts "part1: %d" % program(inputs).last
puts "part2: %s" % ending_swap.last if ending_swap
