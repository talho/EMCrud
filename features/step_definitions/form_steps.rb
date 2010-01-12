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

When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, name|
  @form.form[name] = (@form.page/"select[id='#{name}'] option").detect{|x| x.content == value}.attr("value")
end

Then /^"([^\"]*)" should be set to "([^\"]*)"$/ do |field, value|
  @form.form[field].should == value
end

Then /^"([^\"]*)" should have "([^\"]*)" selected$/ do |field, value|
  @form.page.at("select[id='#{field}'] option[value='#{@form.form[field]}']").content.should == value
end
