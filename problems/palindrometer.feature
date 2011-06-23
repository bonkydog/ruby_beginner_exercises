Feature: Palindrometer
  Write a program that recognizes palindromes.
  Fun palindrome trivia: http://en.wikipedia.org/wiki/Palindrome

  Scenario: Recognize non-palindrome
    When I run the command "ruby palindrometer.rb 'blurgle.'"
    Then it should print "Nope, it's not a palindrome."

  Scenario: Recognize palindrome
    When I run the command "ruby palindrometer.rb 'gateman nametag'"
    Then it should print "Yep, it's a palindrome!"

  Scenario: Recognize palindrome, ignoring spaces, punctuation, and capitalization
    When I run the command "ruby palindrometer.rb 'I roamed under it, a tired nude Maori.'"
    Then it should print "Yep, it's a palindrome!"