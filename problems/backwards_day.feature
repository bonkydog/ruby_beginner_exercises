Feature: Backwards Day!
  Write a program that asks the user for her name,
  then announces that it is backwards day, so her name is
  actually whatever it is spelled backwards.

  Scenario: It's backwards day
    When I run the command "ruby backwards_day.rb"
    Then it should print "Hi, what's your name?"
    When I type "Brian"
    Then it should print "Today is Backwards Day!"
    And it should print "Your name is actually Nairb!"
    