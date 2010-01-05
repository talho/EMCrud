When /^I request the onsite registration portal$/ do
  FakeWeb.register_uri :get, Registration.base_uri+'?page=EditWalkOnRegistration&service=page',
                       :body => load_fixture('onsite_reg'), :content_type => "text/html"
  @registration = Registration.new
end

Then /^I see a current event selection with the following:$/ do |table|
  table.raw.each do |row|
    @registration.events.should include(row.first)
  end
end
Then /^I see "([^\"]*)" in the list of fields$/ do |name|
  @registration.field_names.should include(name)
end
When /^I set "([^\"]*)" to "([^\"]*)"$/ do |field, value|
  @registration.send "#{field}=", value
end
Then /^"([^\"]*)" should be set to "([^\"]*)"$/ do |field, value|
  @registration.form[field].should == value
end