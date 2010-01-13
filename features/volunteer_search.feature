Feature: Searching for volunteers
  In order to see our volunteers
  As a client program
  I should be able to search for volunteers
  
  Background:
    Given I am logged in as "sally"

  Scenario: Searching for users by name
    When I request the volunteer search page
    And I set "firstname" to "John" 
    And I set "lastname" to "Smith"
    And I submit the search
    Then I should see "John Smith" in the search results
    And I should see a link to a profile "John Smith"
    And "John Smith" has the attributes:
      | city  | Anytown      |
      | state | Texas        | 
      | phone | 123-456-7890 |
      | language | English   |
    
    