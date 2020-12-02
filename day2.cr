record(Row, from : Int32, to : Int32, of : Char, pw : String)

inputs =
  File
    .read("input.day2")
    .lines.map(&.split(/[ \-:]+/))
    .map { |row| Row.new(row[0].to_i, row[1].to_i, row[2][0], row[3]) }

puts "part1: %s" % inputs.count { |r| (r.from..r.to).covers?(r.pw.count(r.of)) }
puts "part2: %s" % inputs.count { |r| (r.pw[r.from - 1] == r.of) ^ (r.pw[r.to - 1] == r.of) }
