require 'spec/stubs/cucumber'
require 'lib/emcrud'
include EMCrud

Before('~@remote') do
  require 'fakeweb'
  FakeWeb.allow_net_connect = false
  
  EMCrud.stub!(:authenticate).and_return(Session.new)
end

def load_fixture(name)
  File.read(File.dirname(__FILE__)+"/../fixtures/#{name}.html") 
end