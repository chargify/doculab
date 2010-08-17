Feature: Viewing document pages

  In order to be enlightened
  As a website visitor
  I want to view document pages
  
  Scenario: View an existing document page written in textile
    Given there is a valid doc file
    When I go to the doculab doc
    Then I should see the doc content