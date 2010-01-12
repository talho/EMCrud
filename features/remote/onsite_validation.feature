@remote
Feature:  Onsite Registration
  In order to register volunteers onsite at an event
  As a user
  I can submit the registration form
  
Background:
  Given I am logged in as "sally"

Scenario: Registering a volunteer
  When I start a new volunteer registration
  Then I see a current event selection with the following:
    | Austin Flash Flooding |
  And I see "name" in the list of fields

  When I set "name" to "Bob"
  Then "name" should be set to "Bob"
  
  When I set "profession" to "dentist"
  And I set "activeHospitalName" to "Sacred Heart"

  Then "activeHospitalName" should be set to "Sacred Heart"
  And "name" should be set to "Bob"

  When I fill out the rest of the required fields

  And I submit the form
  Then "Bob" is registered
