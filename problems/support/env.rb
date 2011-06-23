SOLUTIONS_DIR = File.expand_path("../../../solutions", __FILE__ )


After do

  timeout = 10
  i = 0
  program_exited = false
  while i < timeout && !program_exited
    program_exited = !!Process.waitpid(@pid, Process::WNOHANG)
    sleep 0.1
    i += 1
  end

  unless program_exited
    fail("Program was supposed to exit, but it didn't")
    Process.kill(@pid)
    Process.waitpid(@pid, Process::WNOHANG)
  end

#  if @pid
#    unless Process.waitpid(@pid, Process::WNOHANG)
#      Process.kill @pid
#      @pid = nil
#    end
#  end
end
$expect_verbose = true