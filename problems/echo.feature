Feature: Echo
  Write a simple version of the Unix "echo" command.
  Type "man echo" to see the command's man page.
  Echo echoes its command line back to the terminal.

  Scenario: Run with one command line argument
    When I run the command "ruby echo.rb foo"
    Then it should print "foo\n"

  Scenario: Run with many command line arguments
    When I run the command "ruby echo.rb foo bar baz bax"
    Then it should print "foo bar baz bax\n"

  Scenario: Run echo with the -n flag
    When I run the command "ruby echo.rb -n foo"
    Then it should print "foo"

