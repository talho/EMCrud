Given 'the "$name" profession form will be requested' do |name|
  FakeWeb.register_uri :post, EMCrud.base_uri,
                       :body => load_fixture("credential_types/#{name.downcase}"), :content_type => "text/html"
  @registration = Registration.new
end

When /^I request the onsite registration portal$/ do
  FakeWeb.register_uri :get, EMCrud.base_uri+'?page=EditWalkOnRegistration&service=page',
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

Given /^the form will submit successfully$/ do
  FakeWeb.register_uri :post, EMCrud.base_uri+'?page=EditWalkOnRegistration&service=page',
                       :body => load_fixture('onsite_reg'), :content_type => "text/html"
end