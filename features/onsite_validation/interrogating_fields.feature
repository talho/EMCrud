Feature:  Interrogating the fieldset for onsite registration
  In order to register volunteers onsite at an event
  a client program should be able to query for required and optional registration fields

Background:
  Given I am logged in as "sally"

Scenario: Registering a volunteer
  When I request the onsite registration portal
  Then I see a current event selection with the following:
    | Austin Flash Flooding |
  Then I see "First Name" in the list of required fields

  When I set event to "Austin Flash Flooding"

  When I set first_name to "Bob"
  And I submit the form
  Then "Bob" is registered

#
#  r = Registration.new
#  r.setup
#  r.event = r.events.last
#  r.first_name = 'Bob'
#  r.submit
#
#  class Registration
#    include LessHappyMapper
#    form '/someurl'
#  end
#  Registration.setup {:username => lkjlkj, :password...} do |r|
#    r.username = 'foo'
#    r.password = 'bar'
#    # r.url = :default
#    # r.required_field_flag = "*"
#  end
#
#  r.required_fields # => [:first_name, :last_name, etc]
#  r.optional_fields # =>