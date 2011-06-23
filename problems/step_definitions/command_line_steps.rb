
When /^I run the command "([^"]*)"$/ do |command|
  Dir.chdir(SOLUTIONS_DIR) do
    @output = `#{command} 2>&1`
  end
end

Then /^it should print "([^"]*)"$/ do |output|
  @output.should == eval(%["#{output}"])
end

