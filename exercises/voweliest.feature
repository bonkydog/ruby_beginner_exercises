Feature: Voweliest word finder
  Write a program which reads in a file and prints the word that has the most vowels in it.
  Fun word trivia here: http://www.rinkworks.com/words/oddities.shtml

  Scenario: Find the voweliest
    Given a file called "input/words" with this content:
      | Ultrarevolutionaries         |
      | Honorificabilitudinitatibus  |
      | Twyndyllyngs Strengths       |
      | Euouae queueing              |
      | Antidisestablishmentarianism |
    When I run the command "ruby voweliest.rb input/words"
    Then it should print "Honorificabilitudinitatibus"
    And it should exit
