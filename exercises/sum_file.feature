Feature: Sum File
  Write a program which reads a text file of numbers and prints out their sum.
  Assume there's one number per line.

  Scenario: Sum numbers in a file
    Given a file called "input/numbers" with this content:
      | 5  |
      | 17 |
      | 23 |
    When I run the command "ruby sum.rb input/numbers"
    Then it should print "45"


