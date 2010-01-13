require 'spec/stubs/cucumber'
require 'lib/emcrud'
include EMCrud

require 'ruby-debug'

Before do
  require 'fakeweb'
  FakeWeb.clean_registry
end

Before('@remote') do
  FakeWeb.allow_net_connect = true
end

Before('~@remote') do
  FakeWeb.allow_net_connect = false
  FakeWeb.register_uri :get, EMCrud.base_uri,
                       :body => load_fixture("signin"),
                       :content_type => "text/html"
  FakeWeb.register_uri :post, EMCrud.base_uri,
                       :body => load_fixture("home"),
                       :content_type => "text/html"                       
end

def load_fixture(name)
  File.read(File.dirname(__FILE__)+"/../fixtures/#{name}.html") 
end