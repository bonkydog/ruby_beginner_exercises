candidate = ARGV.first.downcase.gsub(/[^a-z]/, '')

if candidate.chars.zip(candidate.reverse.chars).all? { |forwards, backwards| forwards == backwards}
  puts "Yep, it's a palindrome!"
else
  puts "Nope, it's not a palindrome."
end
