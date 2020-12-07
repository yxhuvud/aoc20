inputs = File
  .read_lines("input.day7")

contained_in = Hash(String, Array(String)).new
contain_counts = Hash(String, Hash(String, Int32)).new
inputs
  .map { |line|
    match = line.match(/(.*) bags contain (.*)./)
    if match
      container = match[1]
      contain_counts[container] ||= {} of String => Int32
      contains = match[2].split(", ")
      contains.each do |contained|
        count, color = contained.split(' ', 2)
        next if count == "no"
        color = color.match(/(.*) bag/).not_nil![1]
        contain_counts[container][color] = count.to_i
        contained_in[color] ||= [] of String
        contained_in[color] << container
      end
    end
  }
seen = Set(String).new

def walk(contained, current, seen)
  contained[current].sum do |color|
    next 0 if color.in?(seen)
    seen << color

    walk(contained, color, seen) + 1
  end
end

puts "part1: %s" % walk(contained_in, "shiny gold", seen)

