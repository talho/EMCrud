When /^I request the volunteer search page$/ do
  FakeWeb.register_uri :get, EMCrud.base_uri+'?page=AdHocSearchPage&service=page',
    :body => load_fixture('search'), 
    :content_type => "text/html"

  FakeWeb.register_uri :post, EMCrud.base_uri,
    :body => load_fixture('search_results'),
    :content_type => "text/html"
  
  When 'I start a new volunteer search'
end

When 'I start a new volunteer search' do
  @form = Search.new
end

When 'I submit the search' do
  @form.search
end

Then 'I should see "$name" in the search results' do |name|
  @form.volunteers.map(&:name).should include(name)
end

Then 'I should see a link to a profile "$name"' do |name|
  @form.volunteers.detect{|v| v.name == name}.url.should_not be_blank
end