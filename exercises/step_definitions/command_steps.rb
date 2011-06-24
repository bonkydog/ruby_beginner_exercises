require "pty"
require "expect"
require 'timeout'


When /^I run the command "([^"]*)"$/ do |command|
  Dir.chdir(WORKING_DIR) do

    @master, @slave = PTY.open

    system("stty raw", :in=>@slave) # disable newline conversion.

    @read_pipe, @write_pipe = IO.pipe

    @pid = spawn(command, :in=>@read_pipe, :out=>@slave, :err => @slave)

    @running_processes ||= []
    @running_processes << @pid

    @read_pipe.close
    @slave.close

  end
end

When /I type "([^"]*)"/ do |input|
  @write_pipe.puts input
end

def output_should_equal(io, expected_output)
  expected_pattern = Regexp.new('\A' + Regexp.escape(expected_output), Regexp::MULTILINE)
  timeout = 3
  output = ""

  Timeout::timeout(timeout) do
    @unconsumed_output ||= ""
    while true
      if not @unconsumed_output.empty?
        c = @unconsumed_output.slice!(0).chr
      elsif !IO.select([io], nil, nil, timeout - 1)
        @unconsumed_output = buf
        break
      elsif io.eof?
        break
      else
        c = io.getc.chr
      end
      output << c
      break if output =~ expected_pattern
    end
  end

  output.should =~ expected_pattern

rescue Timeout::Error
  fail "Program was still printing output after #{timeout} seconds.  Output was: #{output.slice(0, 200)}..."
end


Then /^it should print "([^"]*)"$/ do |output|
  output_should_equal(@master, output + "\n")
end

Then /^it should print "([^"]*)" without a newline$/ do |output|
  output_should_equal(@master, output)
end

Then /^it should exit$/ do
  begin
    timeout = 10
    i = 0
    program_exited = false
    while i < timeout && !program_exited
      program_exited = !!Process.waitpid(@pid, Process::WNOHANG)
      sleep 0.1
      i += 1
    end

    unless program_exited
      Process.kill(@pid)
      Process.waitpid(@pid, Process::WNOHANG)
      fail("Program was supposed to exit, but it didn't")
    end

    unless @unconsumed_output.empty?
      fail("Program printed unexpected output: '#{@unconsumed_output}'")
    end
    
  ensure
    @pid = nil
  end
end