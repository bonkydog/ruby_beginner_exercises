words = File.read(ARGV.first).split
puts words.sort_by{|x| x.gsub(/[^aeiou]/, '').length }.last
puts "foo"