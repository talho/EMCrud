@remote
Feature: A user signing in
  In order to do everything
  As a user
  I can sign in
  
  Scenario: A user signing in successfully
    Given a valid user
    When I sign in as a valid user
    Then I should be signed in
    