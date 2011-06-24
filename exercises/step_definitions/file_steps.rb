Given /^a file called "([^"]*)" with this content:$/ do |file_name, content|
  Dir.chdir(WORKING_DIR) do
    directory = File.dirname(file_name)
    FileUtils.mkdir_p(directory) unless directory == ""
    File.open(file_name, "w") do |f|
      content.raw.each do |row|
        line = row.first
        f.puts(line)
      end
    end
  end
end