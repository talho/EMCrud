require 'spec/stubs/cucumber'
require 'lib/emcrud'
include EMCrud

require 'ruby-debug'

class EMCrud::FakeSession < EMCrud::Session
  def initialize(response = '')
  end
end

Before('~@remote') do
  require 'fakeweb'
  FakeWeb.allow_net_connect = false
  FakeWeb.clean_registry
  EMCrud.stub!(:authenticate).and_return(FakeSession.new)
end

def load_fixture(name)
  File.read(File.dirname(__FILE__)+"/../fixtures/#{name}.html") 
end