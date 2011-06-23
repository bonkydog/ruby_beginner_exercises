sum = 0
File.readlines(ARGV.first).each do |line|
  sum += line.to_i
end
puts sum