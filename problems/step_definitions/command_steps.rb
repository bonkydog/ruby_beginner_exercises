require "pty"
require "expect"
require 'timeout'


When /^I run the command "([^"]*)"$/ do |command|
  Dir.chdir(SOLUTIONS_DIR) do

    @master, @slave = PTY.open

    system("stty raw", :in=>@slave) # disable newline conversion.

    @read_pipe, @write_pipe = IO.pipe

    @pid = spawn(command, :in=>@read_pipe, :out=>@slave)

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
  expected_pattern = Regexp.new("^" + Regexp.escape(expected_output))
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


Then /^it should print "([^"]*)"( without a newline)?$/ do |output, without_newline|
  maybe_a_newline = without_newline.nil? ? "\n" : ''
  output_should_equal(@master, output + maybe_a_newline)
end
