Given 'a valid user' do
  filename = File.dirname(__FILE__)+'/../support/credentials.yml'
  raise 'You need a valid user. See features/support/credentials.sample.yml for instructions.' unless File.exist?(filename)
  require 'yaml'
  @credentials = YAML::load_file(filename)
end

Given /^I am logged in as "([^\"]*)"$/ do |name|
  Given 'a valid user'
  When 'I sign in as a valid user'
end

When 'I sign in as a valid user' do
  @session = EMCrud.authenticate @credentials['username'], @credentials['password']
end

Then 'I should be signed in' do
  @session.should be_authenticated
end