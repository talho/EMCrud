Feature:  Registering an on-site volunteer
  In order to register volunteers onsite at an event
  a client program should be able to query for required and optional registration fields

  Background:
    Given I am logged in as "sally"

  Scenario: Registering a volunteer
    When I request the onsite registration portal
    Then I see a current event selection with the following:
      | Austin Flash Flooding |
    And I see "name" in the list of fields

    When I set "name" to "Bob"
    Then "name" should be set to "Bob"

    When I set "event" to "Austin Flash Flooding"
    Then "event" should be set to "Austin Flash Flooding"
  
    Given the "Dentist" profession form will be requested
    When I set "profession" to "Dentist"
    And I set "activeHospitalName" to "Sacred Heart"

    Then "activeHospitalName" should be set to "Sacred Heart"

    Given the form will submit successfully
    And I submit the form
    Then "Bob" is registered
