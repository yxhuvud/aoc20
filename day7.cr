contained_in = Hash(String, Array(String)).new
contain_counts = Hash(String, Hash(String, Int32)).new

File.each_line("input.day7") do |line|
  if match = line.match(/(.*) bags contain (.*)./)
    container = match[1]
    contain_counts[container] ||= {} of String => Int32
    match[2].split(", ").each do |contained|
      count, color = contained.split(' ', 2)
      color = color.gsub(/ bags?/, "")
      contain_counts[container][color] = count.to_i rescue 0
      contained_in[color] ||= [] of String
      contained_in[color] << container
    end
  end
end

def walk(contained, current, seen = Set(String).new)
  contained.fetch(current, Array(String).new).sum do |color|
    seen.add?(color) ? 1 + walk(contained, color, seen) : 0
  end
end

def walk2(counts, current) : Int32
  1 + counts[current].sum { |color, count| count * walk2(counts, color) }
end

puts "part1: %s" % walk(contained_in, "shiny gold")
puts "part2: %s" % (walk2(contain_counts, "shiny gold") - 1)
