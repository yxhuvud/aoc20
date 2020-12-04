def all(pp)
  %w(byr iyr eyr hgt hcl ecl pid).all? { |field| pp[field]? }
end

def valid?(pp)
  ("1920".."2002") === pp["byr"] &&
    ("2010".."2020") === pp["iyr"] &&
    ("2020".."2030") === pp["eyr"] &&
    (("150".."193cm") === pp["hgt"] || ("59".."76in") === pp["hgt"]) && /\A\d{3}cm\z|\A\d\din\z/ === pp["hgt"] &&
    /\A#[0-9a-f]{6}\z/ === pp["hcl"] &&
    %w[amb blu brn gry grn hzl oth].includes?(pp["ecl"]) &&
    pp["pid"].size == 9
end

inputs = File
  .read("input.day4")
  .split("\n\n")
  .map &.split
    .to_h do |pair|
      pairs = pair.split(':')
      {pairs[0], pairs[1]}
    end

puts "part1: %s" % inputs.count { |pp| all(pp) }
puts "part2: %s" % inputs.count { |pp| all(pp) && valid?(pp) }
