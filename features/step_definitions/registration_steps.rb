Given 'the "$name" profession form will be requested' do |name|
  FakeWeb.register_uri :post, EMCrud.base_uri,
                       :body => load_fixture("credential_types/#{name.downcase}"),
                       :content_type => "text/xml"
  @form = Registration.new
end

When /^I request the onsite registration portal$/ do
  FakeWeb.register_uri :get, EMCrud.base_uri+'?page=EditWalkOnRegistration&service=page',
                       :body => load_fixture('onsite_reg'), :content_type => "text/html"
  When 'I start a new volunteer registration'
end

When 'I start a new volunteer registration' do
  @form = Registration.new
end

Given /^the form will submit successfully$/ do
  FakeWeb.register_uri :post, EMCrud.base_uri+'?page=EditWalkOnRegistration&service=page',
                       :body => load_fixture('onsite_reg'), :content_type => "text/html"
end