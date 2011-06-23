if ARGV[0] == "-n"
  print ARGV.slice(1,ARGV.size-1).join(" ")
else
  print ARGV.join(" ") + "\n"
end

