Then /^I see a current event selection with the following:$/ do |table|
  table.raw.each do |row|
    @form.events.should include(row.first)
  end
end

Then /^I see "([^\"]*)" in the list of fields$/ do |name|
  @form.field_names.should include(name)
end

When /^I set "([^\"]*)" to "([^\"]*)"$/ do |field, value|
  @form.send "#{field}=", value
end

Then /^"([^\"]*)" should be set to "([^\"]*)"$/ do |field, value|
  @form.form[field].should == value
end