Before('~@remote') do
  require 'fakeweb'
  FakeWeb.allow_net_connect = false
end

require 'lib/emcrud'
include EMCrud

def load_fixture(name)
  File.read(File.dirname(__FILE__)+"/../fixtures/#{name}.html") 
end